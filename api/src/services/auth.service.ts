import Services from "./services";
import bcrypt from "bcrypt"
import ClientDTO from "../dto/client.dto";
import Client from "../entity/client.entity";
import HttpException from "../exceptions/http.exceptions";
import CredentialsDTO from "../dto/credentials.dto";
import StoreAllToken from "../interfaces/store.all.token.interface";
import TokenData from "../interfaces/token.data.interface";
import Sessions from "../entity/sessions.entity";
import EmailFoundHttpException from "../exceptions/email.found.http.exception";
import HashHttpException from "../exceptions/hash.http.exception";
import DatabaseHttpException from "../exceptions/database.http.exception";
import SessionHttpException from "../exceptions/session.http.exception";

export default class AuthService extends Services{
  constructor(){
    super();
  }

  public createSession(type: string,description: string = ' ', tokenData: TokenData,sessionId: string): Sessions{
    const session: Sessions = new Sessions;
    session.type = type;
    session.description = description;
    session.expiresIn = tokenData.expiresIn;
    session.iat = tokenData.iat;
    session.id = sessionId;
    return session;
  }

  public async register(clientData: ClientDTO): Promise<boolean>{
    var client: Client;
    var sessions: Sessions[];
    var sessionId: string;
    clientData.credentialsDTO.email = clientData.credentialsDTO.email.toLowerCase();
    try {
      client = await this.database.findClientByEmail(clientData.credentialsDTO);
    } catch (error) {
      throw error;
    }
    if(client){
      throw new EmailFoundHttpException(clientData.credentialsDTO.email);
    }
    try {
      const hashedPassword = await bcrypt.hash(clientData.credentialsDTO.password, 10);
      clientData.credentialsDTO.password = hashedPassword;
      try {
        sessionId = this.generateSessionId();
      } catch (error) {
        throw new SessionHttpException("GENERATE", error.message);
      }
      const accessToken: TokenData = this.jwt.createAccessToken(sessionId);
      try {
        sessions = [this.createSession("LOGIN",' ',accessToken,sessionId)];
      } catch (error) {
        throw new SessionHttpException("CREATE", error.message);
      }
    } catch (error) {
      throw new HashHttpException(error.message);
    }
    try {
      clientData.sessionsDTO = sessions;
      const result = await this.database.insertClient(clientData);
      if(result){
        return true;
      }
      return false
    } catch (error) {
      throw new DatabaseHttpException(error.message);
    }
  }

  public async refresh(id: string ): Promise<StoreAllToken> {
    var client: Client;
    var sessionId: string;
    var session: Sessions;
      try {
        client = await this.database.findClientById(id);
      } catch (error){
        throw error;
      }
      if (client) {
        try{
          await this.updateClientSessions(client);
        }catch (error) {
          throw new DatabaseHttpException(error.message);
        }
        try {
          sessionId = this.generateSessionId();
        } catch (error) {
          throw new SessionHttpException("GENERATE", error.message);
        }
      
        const accessToken: TokenData = this.jwt.createAccessToken(sessionId);
        
        try {
          session = this.createSession("LOGIN"," ",accessToken,sessionId);
        } catch (error) {
          throw new SessionHttpException("CREATE", error.message);
        }
        
        const refreshToken: TokenData = this.jwt.createRefreshToken(client.id);
        const allToken: StoreAllToken = {accessToken,refreshToken};
        session.client = client;
        try{
          await this.database.insertClientSessions(session);
        }catch (error) {
          throw new DatabaseHttpException(error.message);
        }
        return allToken;
      }
      return null;
  }

  public async updateClientSessions(client: Client){
      const time: number = Math.floor(Date.now() / 1000);
      client.sessions.forEach( async (session) => {
        if (session.expiresIn < time || session.type == "RESET_PASSWORD") {
          try{
            await this.database.deleteClientSessions(session);
          } catch (error) {
            throw new DatabaseHttpException(error.message);
          }
        }
      });
    }
     
  public async updateClientSessionByClientId(id: string){
    const client = await this.database.findClientById(id);
    const time: number = Math.floor(Date.now() / 1000);
    client.sessions.forEach( async (session) => {
      if (session.expiresIn < time || session.type == "RESET_PASSWORD") {
        await this.database.deleteClientSessions(session);
      }
    });
  }

  public async login(credentialsDTO: CredentialsDTO): Promise<StoreAllToken> {
      try {
        credentialsDTO.email = credentialsDTO.email.toLowerCase();
        const client: Client = await this.database.findClientByEmail(credentialsDTO);
        if(client){
          const isMatch = await bcrypt.compare(
            credentialsDTO.password,
            client.credentials.password
          );
          if(isMatch){
            await this.updateClientSessions(client);
            const sessionId = this.generateSessionId();
            const accessToken: TokenData = this.jwt.createAccessToken(sessionId);
            const session: Sessions = this.createSession("LOGIN"," ",accessToken,sessionId);
            const refreshToken: TokenData = this.jwt.createRefreshToken(client.id);
            const allToken: StoreAllToken = {accessToken,refreshToken};
            session.client= client;
            await this.database.insertClientSessions(session);

            return allToken;
          }
        }
      } catch (error) {
        throw( new HttpException(404,error.message));
      }
      throw( new HttpException(404,"Not Found"));
  }

  public async recoverypassword(credentialsDTO: CredentialsDTO){
      try {
        const hashedPassword = await bcrypt.hash(credentialsDTO.password,10);
        credentialsDTO.password = hashedPassword;
        this.database.updateCredentials(credentialsDTO);;
      } catch (error) {
        throw new HttpException(404,error.message);
      }
  }
   
  public async sendEmail(credentialsDTO: CredentialsDTO){
      try {
        const client = await this.database.findClientByEmail(credentialsDTO);
        if(client){
          await this.updateClientSessions(client);
          const sessionId = this.generateSessionId();
          const accessToken: TokenData = this.jwt.createAccessToken(sessionId);
          const session: Sessions = this.createSession("RESET_PASSWORD"," ",accessToken,sessionId);
          session.client = client;
          const sessions = await this.database.insertClientSessions(session);
          
          const clientDTO = new ClientDTO();
          clientDTO.id =  client.id;
          clientDTO.credentialsDTO = client.credentials;
          clientDTO.personDTO = client.person;
          clientDTO.sessionsDTO= [sessions];
          const link = `https://api-pdm-pia3.herokuapp.com/auth/reset-password/`+accessToken.token;
          const result = await this.email.sendEmail(clientDTO,link);
          if(!result){
            throw new HttpException(404,"Not Found!");
          }
        }else{
          throw new HttpException(404,"Not Found!");
        }
      } catch (error) {
        throw new HttpException(404,error.message);
      }
  }
}
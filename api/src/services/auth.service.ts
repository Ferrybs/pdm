import Services from "./services";
import bcrypt from "bcrypt"
import ClientDTO from "../dto/client.dto";
import Client from "../entity/client.entity";
import CredentialsDTO from "../dto/credentials.dto";
import TokenData from "../interfaces/token.data.interface";
import Sessions from "../entity/sessions.entity";
import EmailFoundHttpException from "../exceptions/email.found.http.exception";
import HashHttpException from "../exceptions/hash.http.exception";
import DatabaseHttpException from "../exceptions/database.http.exception";
import SessionHttpException from "../exceptions/session.http.exception";
import ServerErrorHttpException from "../exceptions/server.error.http.exception";
import EmailNotSendHttpException from "../exceptions/email.not.send.exception";
import NotFoundHttpException from "../exceptions/not.found.http.exception";

export default class AuthService extends Services{
  constructor(){
    super();
  }
  private async _addSession(session: Sessions): Promise<Sessions>{
    try{
    if(session){
      return await this.database.insertClientSessions(session);
    }else{
      throw new SessionHttpException("INSERT","Session is null");
    }
    }catch (error) {
    throw new DatabaseHttpException(error.message);
    }
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
      throw new DatabaseHttpException(error.message);
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
  public async getNewRefreshToken(sessionId: string ): Promise<TokenData>{
    var client: Client;
    if(await this.isValidSession(sessionId)){
      client = await this.database.findClientBySessionId(sessionId);

      if(client){
        await this.updateClientSessionByClientId(client.id);
        try {
          return this.jwt.createRefreshToken(client.id);
        } catch (error) {
          throw new HashHttpException(error.message);
        }
      }
    }else{
      throw new NotFoundHttpException("CLIENT");
    }
    
  }
  public async refresh(id: string ): Promise<TokenData> {
    var client: Client;
    var sessionId: string;
    var session: Sessions;
    var accessToken: TokenData;
      
    client = await this.database.findClientById(id);
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
    
      try {
        accessToken = this.jwt.createAccessToken(sessionId);
      } catch (error) {
        throw new HashHttpException(error.message);
      }
      
      try {
        if(accessToken){
          session = this.createSession("LOGIN"," ",accessToken,sessionId);
        }
      } catch (error) {
        throw new SessionHttpException("CREATE", error.message);
      }
      if(session){
        session.client = client;
        await this._addSession(session);
      }else{
        throw new SessionHttpException("CREATE","Failed to assign client to session");
      }
      return accessToken;
    }
    throw new NotFoundHttpException("CLIENT");
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
  
  public async isValidSession(sessionId: string): Promise<boolean> {
    const client = await this.database.findClientBySessionId(sessionId);
    const time: number = Math.floor(Date.now() / 1000);
    if (client) {
      const session =  client.sessions.find((session)=>{
        if(session.id === sessionId && session.expiresIn > time){
          return session;
        }
      });
      if(session){
        return true;
      }
    }else{
      throw new NotFoundHttpException("CLIENT");
    }
    return false;
  }   
  public async updateClientSessionByClientId(id: string){
    const client = await this.database.findClientById(id);
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

  public async login(credentialsDTO: CredentialsDTO): Promise<TokenData> {
    var client: Client;
    var isMatch = false;
    var accessToken: TokenData;
    var session: Sessions;
    credentialsDTO.email = credentialsDTO.email.toLowerCase();
    try {
      client = await this.database.findClientByEmail(credentialsDTO);
    } catch (error) {
      throw new DatabaseHttpException(error.message);
    }
    if(client){
      try {
        isMatch = await bcrypt.compare(
          credentialsDTO.password,
          client.credentials.password
        );
      } catch (error) {
        throw new HashHttpException(error.message);
      }
        if(isMatch){
          
          try{
            await this.updateClientSessions(client);
          } catch (error) {
            throw new SessionHttpException("UPDATE",error.message);
          }
          
          try {
            const sessionId = this.generateSessionId();
            accessToken = this.jwt.createAccessToken(sessionId);
            session = this.createSession("LOGIN"," ",accessToken,sessionId);
            session.client= client;
          } catch (error) {
            throw new HashHttpException(error.message);
          }

          await this._addSession(session);
          return accessToken;

        }else{
          throw new NotFoundHttpException("CLIENT");
        }
      
    }
    throw( new ServerErrorHttpException("Client Not Found!"));
  }

  public async recoverypassword(credentialsDTO: CredentialsDTO){
      try {
        const hashedPassword = await bcrypt.hash(credentialsDTO.password,10);
        credentialsDTO.password = hashedPassword;
        this.database.updateCredentials(credentialsDTO);;
      } catch (error) {
        throw new DatabaseHttpException(error.message);
      }
  }
   
  public async sendEmail(credentialsDTO: CredentialsDTO){
    var sessionId: string;
    var session: Sessions;
    var sessions: Sessions;
      try {
        const client = await this.database.findClientByEmail(credentialsDTO);
        if(client){
          try {
            await this.updateClientSessions(client);
          } catch (error) {
            throw new DatabaseHttpException(error.message);
          }
          
          try {
            sessionId = this.generateSessionId();
          } catch (error) {
            throw new SessionHttpException("GENERATE", error.message);
          }
          
          const accessToken: TokenData = this.jwt.createAccessToken(sessionId);
          try {
            session = this.createSession("RESET_PASSWORD"," ",accessToken,sessionId);
          } catch (error) {
            throw new SessionHttpException("CREATE", error.message);
          }
          
          session.client = client;
          try {
            sessions = await this._addSession(session);
          } catch (error) {
            throw new DatabaseHttpException(error.message);
          }
          
          const clientDTO = new ClientDTO();
          clientDTO.id =  client.id;
          clientDTO.credentialsDTO = client.credentials;
          clientDTO.personDTO = client.person;
          clientDTO.sessionsDTO= [sessions];
          const result = await this.email.sendEmail(clientDTO,accessToken.token);
          if(!result){
            throw new EmailNotSendHttpException("e-mail not send");
          }
        }else{
          throw new EmailFoundHttpException(credentialsDTO.email);
        }
      } catch (error) {
        throw new DatabaseHttpException(error.message);
      }
  }
}
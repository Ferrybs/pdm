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
import EmailNotSendHttpException from "../exceptions/email.not.send.exception";
import NotFoundHttpException from "../exceptions/not.found.http.exception";
import TypeSession from "../entity/type.session.entity";
import SessionsDTO from "../dto/sessions.dto";
import Credentials from "../entity/credentials.entity";
import { plainToInstance } from "class-transformer";
import Person from "../entity/person.entity";
import DataStoreToken from "../interfaces/data.store.token.interface";
import SendEmailDTO from "dto/send.email.dto";
import LoginDTO from "dto/login.dto";
import RegisterDTO from "dto/register.dto";

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

  public async getSessions(id: string): Promise<SessionsDTO[]>{
    const client = await this.database.findClientBySessionId(id);
    return await this.database.findSessionsByClient(client);
  }

  public async createSession(type: TypeSession,description: string = ' ', tokenData: TokenData,sessionId: string): Promise<Sessions>{
    const session = new Sessions();
    type.type = type.type.toUpperCase();
    if(await this.database.findTypeSession(type)){
      session.type = type;
    }else{
      throw new NotFoundHttpException("TYPE_SESSION");
    }
    session.description = description;
    session.expiresIn = tokenData.expiresIn;
    session.iat = tokenData.iat;
    session.id = sessionId;
    return session;
  }

  public async register(registerDTO: RegisterDTO): Promise<boolean>{
    const credentials = new Credentials();
    credentials.email = registerDTO.loginDTO.email.toLowerCase();
    credentials.password = registerDTO.loginDTO.password;
    
    if(await this.database.findClientByEmail(credentials)){
      throw new EmailFoundHttpException(credentials.email);
    }
    try {
      credentials.password = await bcrypt.hash(credentials.password, 10); 
    } catch (error) {
      throw new HashHttpException(error.message);
    }
    const client = new Client();
    client.person = plainToInstance(Person,registerDTO.personDTO);
    client.credentials = credentials;
    const result = await this.database.insertClient(client);
    if(result){
      return true;
    }
    return false;
  }
  public async getNewRefreshToken(dataStoreToken: DataStoreToken ): Promise<TokenData>{
    var client: Client;
    var session: Sessions;
    var refreshToken: TokenData;
      client = await this.database.findClientBySessionId(dataStoreToken.id);

      if(client){
        await this.updateClientSessionsByClientId(client.id);

        const sessionId = this.generateSessionId();
        const sessionType = this.getRefreshTokenTypesession();
        try {
          refreshToken = this.jwt.createRefreshToken(client.id,sessionType.id);
        } catch (error) {
          throw new HashHttpException(error.message);
        }
        
        if(refreshToken){
          session = await this.createSession(sessionType," ",refreshToken,sessionId);
        }else{
          throw new SessionHttpException("CREATE","Refresh Token is Null!");
        }
        
        if(session){
          session.client = client;
          await this._addSession(session);
        }else{
          throw new SessionHttpException("CREATE","Failed to assign client to session");
        }
        return refreshToken;
      }
      throw new NotFoundHttpException("CLIENT");

  }
  public async getNewAccessToken(id: string ): Promise<TokenData> {
    var client: Client;
    var sessionId: string;
    var session: Sessions;
    var accessToken: TokenData;
      
    client = await this.database.findClientById(id);
    if (client) {
      await this.updateClientSessionsByClientId(client.id);
    
      sessionId = this.generateSessionId();
      const sessionType = this.getLoginTypesession();
      try {
        accessToken = this.jwt.createAccessToken(sessionId,sessionType.id);
      } catch (error) {
        throw new HashHttpException(error.message);
      }
      
      try {
        if(accessToken){
          session = await this.createSession(sessionType," ",accessToken,sessionId);
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
  
  public async updateClientSessionsByClientId(id: string){
    const sessions = await this.database.findSessionsByClientid(id);
    const time: number = Math.floor(Date.now() / 1000);
    sessions.forEach( async (session) => {
      if (session.expiresIn < time || session.type.id == "2") {
        try{
          await this.database.deleteClientSessions(session);
        } catch (error) {
          throw new DatabaseHttpException(error.message);
        }
      }
    });
  }

  public async login(loginDTO: LoginDTO): Promise<TokenData> {
    var client: Client;
    var isMatch = false;
    var accessToken: TokenData;
    var session: Sessions;
    loginDTO.email = loginDTO.email.toLowerCase();

    client = await this.database.findClientByEmail(loginDTO);
    
    if(client){
      try {
        isMatch = await bcrypt.compare(
          loginDTO.password,
          client.credentials.password
        );
      } catch (error) {
        throw new HashHttpException(error.message);
      }
      if(isMatch){
        try{
          await this.updateClientSessionsByClientId(client.id);
        } catch (error) {
          throw new SessionHttpException("UPDATE",error.message);
        }
        
        try {
          const sessionId = this.generateSessionId();
          const sessionType = this.getLoginTypesession();
          accessToken = this.jwt.createAccessToken(sessionId,sessionType.id);
          session = await this.createSession(sessionType," ",accessToken,sessionId);
          session.client= client;
        } catch (error) {
          throw new HashHttpException(error.message);
        }

        await this._addSession(session);
        return accessToken;
      }
    }
    throw( new NotFoundHttpException("CLIENT"));
  }
   
  public async sendEmail(sendEmailDTO: SendEmailDTO){
    var sessionId: string;
    var session: Sessions;
    var sessions: Sessions;
    const credentials = new CredentialsDTO();
    credentials.email = sendEmailDTO.email;
    const client = await this.database.findClientByEmail(credentials);
    if(client){
      await this.updateClientSessionsByClientId(client.id);
      
      
      try {
        sessionId = this.generateSessionId();
      } catch (error) {
        throw new SessionHttpException("GENERATE", error.message);
      }
      const sessionType = this.getResetPasswordTypesession();
      const accessToken: TokenData = this.jwt.createAccessToken(sessionId,sessionType.id);
      try {
        session = await this.createSession(sessionType," ",accessToken,sessionId);
      } catch (error) {
        throw new SessionHttpException("CREATE", error.message);
      }
      
      session.client = client;
      sessions = await this._addSession(session);
      
      
      const clientDTO = new ClientDTO();
      clientDTO.id =  client.id;
      clientDTO.credentialsDTO = client.credentials;
      clientDTO.personDTO = client.person;
      
      const result = await this.email.sendEmail(clientDTO,accessToken.token);
      if(!result){
        throw new EmailNotSendHttpException("e-mail not send");
      }else{
        return true;
      }
    }else{
      throw new NotFoundHttpException("CLIENT");
    }
  }
}
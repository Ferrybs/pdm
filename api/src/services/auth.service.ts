import Services from "./services";
import bcrypt from "bcrypt"
import ClientDTO from "../dto/client.dto";
import Client from "../entity/client.entity";
import ClientWithThatEmailAlreadyExistsException from "../exceptions/client.email.exist";
import HttpException from "../exceptions/http.exceptions";
import CredentialsDTO from "../dto/credentials.dto";
import ClientStoreToken from "../interfaces/client.store.token.interface";
import StoreAllToken from "../interfaces/store.all.token.interface";
import TokenData from "../interfaces/token.data.interface";
import Sessions from "../entity/sessions.entity";

export default class AuthService extends Services{
  constructor(){
    super();
  }
  public createSession(description: string = ' ', tokenData: TokenData,sessionId: string): Sessions{
    const session: Sessions = new Sessions;
    session.description = description;
    session.expiresIn = tokenData.expiresIn;
    session.iat = tokenData.iat;
    session.id = sessionId;
    return session;
  }
  public async register(clientData: ClientDTO): Promise<ClientStoreToken>{
    try {
      clientData.credentialsDTO.email = clientData.credentialsDTO.email.toLowerCase();
      if(await this.database.findClientByEmail(clientData.credentialsDTO)){
        throw new ClientWithThatEmailAlreadyExistsException(clientData.credentialsDTO.email);
      }
      const hashedPassword = await bcrypt.hash(clientData.credentialsDTO.password, 10);
      clientData.credentialsDTO.password = hashedPassword;

      const sessionId = this.generateSessionId();
      const accessToken: TokenData = this.jwt.createAccessToken(sessionId);
      const sessions = [this.createSession(" ",accessToken,sessionId)];

      clientData.sessionsDTO = sessions;
      const result = await this.database.insertClient(clientData);
      const clientDTO = new ClientDTO();
      clientDTO.id = result.id;
      clientDTO.credentialsDTO = result.credentials;
      clientDTO.personDTO = result.person;
      clientDTO.sessionsDTO = result.sessions;
      clientDTO.credentialsDTO.password = null;

      const refreshToken: TokenData = this.jwt.createRefreshToken(result.id);
      const allToken: StoreAllToken = {accessToken,refreshToken};
      const clientStoreToken: ClientStoreToken = {clientDTO,allToken};
      return clientStoreToken;
    } catch (error) {
      throw (new HttpException(404,error.message))
    }
  }

  public async refresh(id: string ): Promise<StoreAllToken> {
      try {
        const client = await this.database.findClientById(id);
        await this.updateClientSessions(client);
        const sessionId = this.generateSessionId();
        const accessToken: TokenData = this.jwt.createAccessToken(sessionId);
        const session: Sessions = this.createSession(" ",accessToken,sessionId);
        const refreshToken: TokenData = this.jwt.createRefreshToken(client.id);
        const allToken: StoreAllToken = {accessToken,refreshToken};
        session.client = client;
        await this.database.insertClientSessions(session);

        return allToken;
      } catch (error) {
        throw( new HttpException(404,error.message));
      }
  }

  public async updateClientSessions(client: Client){
      const time: number = Math.floor(Date.now() / 1000);
      client.sessions.forEach( async (session) => {
        if (session.expiresIn < time || session.description == "RESET_PASSWORD") {
          await this.database.deleteClientSessions(session);
        }
      });
    }
    public async updateClientSessionByClientId(id: string){
      const client = await this.database.findClientById(id);
      const time: number = Math.floor(Date.now() / 1000);
      client.sessions.forEach( async (session) => {
        if (session.expiresIn < time || session.description == "RESET_PASSWORD") {
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
            const session: Sessions = this.createSession(" ",accessToken,sessionId);
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
          const session: Sessions = this.createSession("RESET_PASSWORD",accessToken,sessionId);
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
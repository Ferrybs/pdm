import Services from "./services";
import bcrypt from "bcrypt"
import TokenData from "../interfaces/token.data.interface";
import ClientDTO from "../dto/client.dto";
import Client from "../entity/client.entity";
import ClientWithThatEmailAlreadyExistsException from "../exceptions/client.email.exist";
import HttpException from "../exceptions/http.exceptions";
import CredentialsDTO from "../dto/credentials.dto";
import PersonDTO from "../dto/person.dto";
import ClientStoreToken from "../interfaces/client.store.token.interface";
import StoreAllToken from "interfaces/store.all.token.interface";

export default class AuthService extends Services{
  constructor(){
    super();
  }
  
  public async register(clientData: ClientDTO): Promise<ClientStoreToken>{
    try {
      if(await this.database.findClientByEmail(clientData.credentialsDTO)){
        throw new ClientWithThatEmailAlreadyExistsException(clientData.credentialsDTO.email);
      }
      const hashedPassword = await bcrypt.hash(clientData.credentialsDTO.password, 10);
      clientData.credentialsDTO.password = hashedPassword;
      const result = await this.database.insertClient(clientData);
      const clientDTO = new ClientDTO();
      clientDTO.id = result.id;
      clientDTO.credentialsDTO = result.credentials;
      clientDTO.personDTO = result.person;
      clientDTO.credentialsDTO.password = null;
      const allToken: StoreAllToken = this.jwt.createToken(clientDTO);
      const clientStoreToken: ClientStoreToken = {clientDTO,allToken};
      return clientStoreToken;
    } catch (error) {
      throw (new HttpException(404,error.message))
    }
  }

    public refresh(clientDTO: ClientDTO): StoreAllToken {
      try {
        if (clientDTO) {
            return this.jwt.createToken(clientDTO);
        }
      } catch (error) {
        throw( new HttpException(404,error.message));
      }
      throw( new HttpException(404,"Not Found"));
    }
    public async login(credentialsDTO: CredentialsDTO): Promise<ClientStoreToken> {
      const clientDTO = new ClientDTO();
      var allToken: StoreAllToken;
      try {
        const client: Client = await this.database.findClientByEmail(credentialsDTO);
        if(client){
          const isMatch = await bcrypt.compare(
            credentialsDTO.password,
            client.credentials.password
          );
          if(isMatch){
            clientDTO.id = client.id;
            clientDTO.personDTO = client.person as PersonDTO;
            clientDTO.credentialsDTO = client.credentials as CredentialsDTO;
            clientDTO.credentialsDTO.password = null;
            allToken = this.jwt.createToken(clientDTO);
            const clientStoreToken: ClientStoreToken = {clientDTO,allToken}
            return clientStoreToken;
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
        credentialsDTO.password = null;
        const client = await this.database.findClientByEmail(credentialsDTO);
        if(client){
          const clientDTO = new ClientDTO();
          clientDTO.id =  client.id;
          clientDTO.credentialsDTO = client.credentials;
          clientDTO.personDTO = client.person;
          const allToken = this.jwt.createToken(clientDTO);
          const link = `https://api-pdm-pia3.herokuapp.com/auth/reset-password/`+allToken.accessToken.token;
          const result = await this.getEmail().sendEmail(clientDTO,link);
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
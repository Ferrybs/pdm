import Services from "./services";
import bcrypt from "bcrypt"
import TokenData from "../interfaces/token.data.interface";
import ClientDTO from "../dto/client.dto";
import Client from "../entity/client.entity";
import ClientWithThatEmailAlreadyExistsException from "../exceptions/client.email.exist";
import HttpException from "../exceptions/http.exceptions";
import CredentialsDTO from "../dto/credentials.dto";
import PersonDTO from "../dto/person.dto";
import ClientStoreToken from "../interfaces/storetoken/client.store.token.interface";

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
      result.credentials.password = null;
      const token: TokenData = this.jwt.createToken(result);
      const clientStoreToken: ClientStoreToken = {clientDTO,token};
      return clientStoreToken;
    } catch (error) {
      throw (new HttpException(404,error.message))
    }
  }
    public async login(credentialsDTO: CredentialsDTO): Promise<ClientStoreToken> {
      const clientDTO = new ClientDTO();
      var token: TokenData;
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
            token = this.jwt.createToken(client);
            const clientStoreToken: ClientStoreToken = {clientDTO,token}
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
          const token = this.jwt.createToken(client);
          this.getEmail().post(token.token,credentialsDTO.email);
        }else{
          throw new HttpException(404,"Not Found!");
        }
      } catch (error) {
        throw new HttpException(404,error.message);
      }
    }
}
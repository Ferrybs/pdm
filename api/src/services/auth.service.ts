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
  
  public async register(clientDTO: ClientDTO): Promise<ClientStoreToken>{
    try {
      const client = await this.database.findClientByEmail(clientDTO.credentialsDTO);
      if(client){
        throw new ClientWithThatEmailAlreadyExistsException(clientDTO.credentialsDTO.email);
      }
      const hashedPassword = await bcrypt.hash(clientDTO.credentialsDTO.password, 10);
      clientDTO.credentialsDTO.password = hashedPassword;
      const result = await this.database.insertClient(clientDTO);
      result.credentials.password = null;
      const token: TokenData = this.jwt.createToken(result);

      return {
        token,
        client
      }
    } catch (error) {
      throw (new HttpException(404,error.message))
    }
  }
    public async login(credentialsDTO: CredentialsDTO) {
      const result = new ClientDTO();
      var token: TokenData;
      try {
        const client: Client = await this.database.findClientByEmail(credentialsDTO);
        if(client){
          const isMatch = await bcrypt.compare(
            credentialsDTO.password,
            client.credentials.password
          );
          if(isMatch){
            result.id = client.id;
            result.personDTO = client.person as PersonDTO;
            result.credentialsDTO = client.credentials as CredentialsDTO;
            result.credentialsDTO.password = null;
            token = this.jwt.createToken(client);
            return {token,result};
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
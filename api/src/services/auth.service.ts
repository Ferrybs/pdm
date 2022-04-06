import Credentials from "../entity/credentials.entity";
import Services from "./services";
import bcrypt from "bcrypt"
import DataStoreToken from "../interfaces/data.store.token.interface";
import TokenData from "../interfaces/token.data.interface";
import jwt from "jsonwebtoken";
import validateEnv from "../utils/validateEnv";
import Person from "../entity/person.entity";
import ClientDTO from "../dto/client.dto";
import Client from "../entity/client.entity";
import ClientWithThatEmailAlreadyExistsException from "../exceptions/client.email.exist";
import HttpException from "../exceptions/http.exceptions";
import CredentialsDTO from "../dto/credentials.dto";
import PersonDTO from "../dto/person.dto";
import { instanceToPlain } from "class-transformer";

export default class AuthService extends Services{
  private appDataSource = this.getAppDataSource()

    public async register(clienteData: ClientDTO){
      await this.appDataSource.initialize()
      if(
        await this.appDataSource.manager.findOneBy(Credentials,{email: clienteData.credentialsDTO.email})
      ){
        this.appDataSource.destroy()
        throw new ClientWithThatEmailAlreadyExistsException(clienteData.credentialsDTO.email);
      }
      try {
        const hashedPassword = await bcrypt.hash(clienteData.credentialsDTO.password, 10);
        clienteData.credentialsDTO.password = hashedPassword;
        const person = this.appDataSource.manager.create(Person,clienteData.personDTO);
        const cred = this.appDataSource.manager.create(Credentials,clienteData.credentialsDTO);
        const client = new Client();
        client.credentials = cred;
        client.person = person;
        await this.appDataSource.manager.save(person);
        await this.appDataSource.manager.save(cred);
        await this.appDataSource.manager.save(client);
        client.credentials.password = null;
        const tokenData = this.createToken(client);
        const cookie = this.createCookie(tokenData);
        await this.appDataSource.destroy()

        return {
          cookie,
          client
      }
      } catch (error) {
        await this.appDataSource.destroy()
        throw (new HttpException(400,error.message))
      }

    }

    public createCookie(tokenData: TokenData) {
        return `Authorization=${tokenData.token}; HttpOnly; Max-Age=${tokenData.expiresIn}`;
      }
    public createToken(client: Client): TokenData {
        const expiresIn = 60 * 60; // an hour
        const secret = validateEnv.JWT_SECRET;
        const dataStoredInToken: DataStoreToken = {
          id: client.id,
        };
        return {
          expiresIn,
          token: jwt.sign(dataStoredInToken, secret, { expiresIn }),
        };
      }
    public async login(credentialsDTO: CredentialsDTO) {
      try {
        await this.appDataSource.initialize()
        const credentialsUser = await this.appDataSource.manager.findOne(Credentials,
          {where: 
            {
              email: credentialsDTO.email
            }
          })
        if(credentialsUser){
          const isMatch = await bcrypt.compare(
            credentialsDTO.password,
            credentialsUser.password
          );
          if(isMatch){
            const client = await this.appDataSource.manager.findOne(
              Client,{where:{credentials: credentialsUser}, relations: ['credentials', 'person']});
            const result = new ClientDTO();
            result.id = client.id;
            result.personDTO = client.person as PersonDTO
            result.credentialsDTO = client.credentials as CredentialsDTO;
            result.credentialsDTO.password = null;
            const tokenData = this.createToken(client);
            const cookie = this.createCookie(tokenData);
            await this.appDataSource.destroy()
        return {
          cookie,
          result
      }
          }
          throw( new HttpException(404,"Not Found"));
        }
      } catch (error) {
        await this.appDataSource.destroy()
        throw( new HttpException(404,error.message));
      }
    }
    public async recoverypassword(client: ClientDTO){
      try {
        await this.appDataSource.initialize()
        const hashedPassword = await bcrypt.hash(client.credentialsDTO.password,10);
        client.credentialsDTO.password = hashedPassword
        const credResul = this.appDataSource.manager.create(Credentials,client.credentialsDTO);
        const personResul = this.appDataSource.manager.create(Person,client.personDTO);
        const result = new Client();
        result.id = client.id;
        result.credentials =credResul;
        result.person = personResul;
        await this.appDataSource.manager.update(Credentials,credResul.email,credResul);
        await this.appDataSource.destroy();
        return
      } catch (error) {
        await this.appDataSource.destroy();
        throw new HttpException(400,error.message);
      }
    }
    public async sendEmail(credentials: CredentialsDTO){
      try {
        credentials.password = null;
        await this.appDataSource.initialize();
        const client = await this.appDataSource.manager.findOne(
          Client,{where:{credentials: credentials}, relations: ['credentials', 'person']});
        await this.appDataSource.destroy();
        if(client){
          const token = this.createToken(client);
          this.getEmail().post(token.token,credentials.email);
        }else{
          throw new HttpException(400,"Not Found!");
        }
      } catch (error) {
        throw new HttpException(400,error.message);
      }
    }
}
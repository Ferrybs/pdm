import Credentials from "../entity/credentials.entity";
import User from "../entity/client.entity";
import Services from "./services";
import bcrypt from "bcrypt"
import DataStoreToken from "../interfaces/data.store.token.interface";
import TokenData from "../interfaces/token.data.interface";
import jwt from "jsonwebtoken";
import validateEnv from "../utils/validateEnv";
import Person from "../entity/person.entity";
import ClientDTO from "../dto/client.dto";
import Client from "../entity/client.entity";
import ClientWithThatEmailAlreadyExistsException from "../exceptions/client.emaill.exist";
import HttpException from "exceptions/http.exceptions";

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
        throw (new HttpException(400,error.message))
      }

    }

    public createCookie(tokenData: TokenData) {
        return `Authorization=${tokenData.token}; HttpOnly; Max-Age=${tokenData.expiresIn}`;
      }
    public createToken(user: User): TokenData {
        const expiresIn = 60 * 60; // an hour
        const secret = validateEnv.JWT_SECRET;
        const dataStoredInToken: DataStoreToken = {
          id: user.idUser,
        };
        return {
          expiresIn,
          token: jwt.sign(dataStoredInToken, secret, { expiresIn }),
        };
      }
}
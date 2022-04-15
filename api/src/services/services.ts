import PostgresDataSource from "../configs/data.source.postgres";
import User from "../entity/client.entity";
import DataSourceDB from "../interfaces/data.source.interface";
import UserDTO from "../dto/client.dto";
import Person from "../entity/person.entity";
import PersonDTO from "../dto/person.dto";
import CredentialsDTO from "../dto/credentials.dto";
import Credentials from "../entity/credentials.entity";
import ClientDTO from "../dto/client.dto";
import SendEmail from "../utils/sendEmail";
import Database from "interfaces/database/database.interface";
import PostgresDatabase from "database/postgres.database";
import AuthJwt from "auth/auth.jwt";
export default class Services {
    private _dataSource: DataSourceDB;
    private _database: Database;
    private _jwt: AuthJwt = new AuthJwt();
    private _email: SendEmail;
    constructor() {
        this._database = new PostgresDatabase();
        this._email = new SendEmail();
        this._dataSource = new PostgresDataSource();
    }

    public get database(){
        return this._database;
    }

    public get jwt(){
        return this._jwt;
    }

    getAppDataSource(){
        return this._dataSource.appDataSource;
    }

    getEmail(){
        return this._email;
    }
    createUser(userData: UserDTO){
        const userRepository = this.getAppDataSource().getRepository(User);
        return userRepository.create({
            person: userData.personDTO,
            credentials: userData.credentialsDTO
        })
    }
    clientFromDTO(clientData: ClientDTO){
        const person = this.personFromDTO(clientData.personDTO);
        const credentials = this.credentialFromDTO(clientData.credentialsDTO);
        const user = new User();
        user.person = person;
        user.credentials = credentials;
        return user;
    }
    credentialFromDTO(credentialsDTO: CredentialsDTO){
        const credentials = new Credentials()
        credentials.email = credentialsDTO.email
        credentials.password = credentialsDTO.password
        return credentials;
    }

    personFromDTO(personDTO: PersonDTO){
        const person = new Person();
        person.name = personDTO.name;
        person.lastName = personDTO.lastName;
        return person;
    }
}
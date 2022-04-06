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
export default class Services {
    private dataSource: DataSourceDB;
    private email: SendEmail;
    constructor() {
        this.email = new SendEmail();
        this.dataSource = new PostgresDataSource();
    }

    getAppDataSource(){
        return this.dataSource.appDataSource;
    }

    getEmail(){
        return this.email;
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
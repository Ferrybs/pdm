import ClientDTO from "../dto/client.dto";
import CredentialsDTO from "../dto/credentials.dto";
import bcrypt from "bcrypt";
import Services from "./services";
import { plainToInstance } from "class-transformer";
import PersonDTO from "../dto/person.dto";
import SessionsDTO from "../dto/sessions.dto";
import DatabaseHttpException from "../exceptions/database.http.exception";
import NotFoundHttpException from "../exceptions/not.found.http.exception";
import Credentials from "../entity/credentials.entity";
import LoginDTO from "dto/login.dto";


export default class ClientService extends Services{

    public async getClientById(id: string){
        try {
            const result = await this.database.findClientById(id);
            if (result){
                const clientDTO = new ClientDTO();
                clientDTO.id = result.id;
                clientDTO.personDTO = result.person;
                clientDTO.credentialsDTO = result.credentials;
                return clientDTO;
            }
            throw new NotFoundHttpException("CLIENT");
        } catch (error) {
            throw (new DatabaseHttpException(error.message));
        }
    }
    public async sessionType(id: string): Promise<string> {
        const session = await this.database.findSessionBySessionId(id);
        if (session) {
            return session.type.id;
        }
        return null;
    }
    public async getClientBySessionId(sessionid: string){
        const result = await this.database.findClientBySessionId(sessionid);
        if (result) {
            result.credentials.password = undefined;
            const clientDTO = new ClientDTO();
            clientDTO.id = result.id;
            clientDTO.personDTO = plainToInstance(PersonDTO,result.person);
            clientDTO.credentialsDTO = plainToInstance(CredentialsDTO,result.credentials);
            return clientDTO;
        }
        throw new NotFoundHttpException("TOKEN","Try with another token!");
    }
    public async updateCredentials(loginDTO: LoginDTO): Promise<boolean> {
        try {
            const hashedPassword =  await bcrypt.hash(loginDTO.password,10);
            loginDTO.password = hashedPassword;
            const credentials = plainToInstance(Credentials,loginDTO);
            return  await this.database.updateCredentials(credentials);
        } catch (error) {
            throw (new DatabaseHttpException(error.message));
        }
    }
    public async getClientByEmail(credentialsData: CredentialsDTO):Promise<ClientDTO>{
        try {
            const client = await this.database.findClientByEmail(credentialsData);
            if (client){
                const personDTO = plainToInstance(PersonDTO,client.person)
                const credentialsDTO = plainToInstance(CredentialsDTO,client.credentials);
                const sessionsDTO = plainToInstance(SessionsDTO,client.sessions);
                const clientDTO = new ClientDTO();
                clientDTO.id = client.id;
                clientDTO.personDTO = personDTO;
                clientDTO.credentialsDTO =credentialsDTO;
                return clientDTO;
            }
            throw new NotFoundHttpException("CLIENT");
        } catch (error) {
            throw new DatabaseHttpException(error.message)
        }
    }
}
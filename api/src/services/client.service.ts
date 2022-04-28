import ClientDTO from "../dto/client.dto";
import CredentialsDTO from "../dto/credentials.dto";
import bcrypt from "bcrypt";
import Services from "./services";
import { plainToInstance } from "class-transformer";
import PersonDTO from "../dto/person.dto";
import SessionsDTO from "../dto/sessions.dto";
import DatabaseHttpException from "../exceptions/database.http.exception";


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
            return null;
        } catch (error) {
            throw (new DatabaseHttpException(error.message));
        }
    }
    public async sessionType(id: string): Promise<string> {
        const client = await this.database.findClientBySessionId(id);
        if (client) {
            const sessions = client.sessions.find((session)=>{
                if(session.id === id){
                    return session;
                }
            });
            if(sessions){
                return sessions.type;
            }
        }
        return null;
    }
    public async getClientBySessionId(sessionid: string){
        try {
            const result = await this.database.findClientBySessionId(sessionid);
            if (result) {
                const clientDTO = new ClientDTO();
                clientDTO.id = result.id;
                clientDTO.personDTO = result.person;
                clientDTO.credentialsDTO = result.credentials;
                clientDTO.sessionsDTO = result.sessions;
                return clientDTO;
            }
            return null;
        } catch (error) {
            throw (new DatabaseHttpException(error.message));
        }
    }
    public async updateCredentials(credentialsDTO: CredentialsDTO): Promise<boolean> {
        try {
            const hashedPassword =  await bcrypt.hash(credentialsDTO.password,10);
            credentialsDTO.password = hashedPassword;
            const result = await this.database.updateCredentials(credentialsDTO);
            if (result){
                return result;
            }
            return null;
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
                clientDTO.sessionsDTO = sessionsDTO;
                return clientDTO;
            }
            return null;
        } catch (error) {
            throw new DatabaseHttpException(error.message)
        }
    }
}
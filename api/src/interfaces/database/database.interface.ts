import ClientDTO from "../../dto/client.dto";
import CredentialsDTO from "../../dto/credentials.dto";
import Client from "../../entity/client.entity";

export default interface Database{
    insertClient(clientDTO: ClientDTO): Promise<Client>;
    findClientById(id: string): Promise<Client>;
    findClientByEmail(credentialsDTO: CredentialsDTO): Promise<Client>;
    updateCredentials(credentialsDTO: CredentialsDTO): Promise<void>;
}
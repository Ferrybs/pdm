import ClientDTO from "dto/client.dto";
import CredentialsDTO from "dto/credentials.dto";
import Client from "entity/client.entity";
import ClientStoreToken from "interfaces/storetoken/client.store.token.interface";

export default interface Database{
    insertClient(clientDTO: ClientDTO): Promise<Client>;
    findClient(credentialsDTO: CredentialsDTO): Promise<Client>;
    updateCredentials(credentialsDTO: CredentialsDTO);
}
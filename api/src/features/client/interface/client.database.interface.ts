import Credentials from "../../../entity/credentials.entity";
import Client from "../../../entity/client.entity";

export default interface ClientDatabase {
    findClientById(id: string): Promise<Client>;
    findClientBySessionId(sessionId: string): Promise<Client>;
    findClientByEmail(email: string): Promise<Client>;

    insertClient(client: Client): Promise<Client>;

    updateCredentials(credentials: Credentials): Promise<boolean>;
}
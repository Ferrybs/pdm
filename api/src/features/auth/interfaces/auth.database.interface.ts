import Client from "entity/client.entity";
import Credentials from "entity/credentials.entity";
import Session from "entity/session.entity";
import TypeSession from "entity/type.session.entity";

export default interface AuthDatabase {
    findTypeSession(typeSession: TypeSession): Promise<TypeSession>;
    findSessionsByClient(client: Client): Promise<Session[]>;
    findSessionsByClientid(id: string): Promise<Session[]>;
    findSessionBySessionId(id: string): Promise<Session>;

    insertClientSessions(session: Session): Promise<Session>;
    insertTypeSession(typeSession: TypeSession): Promise<TypeSession>;

    updateCredentials(credentiats: Credentials): Promise<boolean>;

    deleteClientSessions(session: Session): Promise<boolean>;
}
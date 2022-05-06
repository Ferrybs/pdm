import Credentials from "models/credentials.entity";
import Device from "models/device.entiy";
import Sessions from "models/sessions.entity";
import TypeSession from "models/type.session.entity";
import Client from "../models/client.entity";

export default interface Database{

    findClientById(id: string): Promise<Client>;
    findClientBySessionId(id: string): Promise<Client>;
    findClientByEmail(credentials: Credentials): Promise<Client>;
    findTypeSession(typeSession: TypeSession): Promise<TypeSession>;
    findDeviceById(id:string): Promise<Device>;
    findDevicesByClient(client:Client): Promise<Device[]>;
    findSessionsByClient(client: Client): Promise<Sessions[]>;
    findSessionsByClientid(id: string): Promise<Sessions[]>;
    findSessionBySessionId(id: string): Promise<Sessions>;

    insertClient(client: Client): Promise<Client>;
    insertClientSessions(session: Sessions): Promise<Sessions>;
    insertDevice(device: Device): Promise<Device>;
    insertTypeSession(typeSession: TypeSession): Promise<TypeSession>;

    updateCredentials(credentiats: Credentials): Promise<boolean>;

    deleteClientSessions(session: Sessions): Promise<boolean>;
}
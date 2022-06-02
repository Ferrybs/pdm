import Credentials from "entity/credentials.entity";
import Device from "entity/device.entity";
import DeviceLocalization from "entity/device.localization.entity";
import DevicePreferences from "entity/device.preferences.entity";
import Measure from "entity/measure.entity";
import Session from "../entity/session.entity";
import TypeSession from "../entity/type.session.entity";
import Client from "../entity/client.entity";
import ChatbotDatabase from "features/chatbot/interfaces/chatbot.database.interface";

export default interface Database extends ChatbotDatabase{

    findClientById(id: string): Promise<Client>;
    findClientBySessionId(id: string): Promise<Client>;
    findClientByEmail(credentials: Credentials): Promise<Client>;
    findTypeSession(typeSession: TypeSession): Promise<TypeSession>;
    findDeviceById(id:string): Promise<Device>;
    findDevicesByClient(client:Client): Promise<Device[]>;
    findSessionsByClient(client: Client): Promise<Session[]>;
    findSessionsByClientid(id: string): Promise<Session[]>;
    findSessionBySessionId(id: string): Promise<Session>;
    findMeasuresByDevice(device: Device,start: Date,end: Date): Promise<Measure[]>;
    findDevicesBySessionId(sessionId: string): Promise<Device[]>;
    findDevicePreferencesByDevice(device: Device): Promise<DevicePreferences>;
    findDeviceLocalizationByDevice(device: Device): Promise<DeviceLocalization>;
    

    insertClient(client: Client): Promise<Client>;
    insertClientSessions(session: Session): Promise<Session>;
    insertTypeSession(typeSession: TypeSession): Promise<TypeSession>;

    insertDevice(device: Device): Promise<Device>;
    insertMeasure(measure: Measure): Promise<Measure>;
    insertDevicePreferences(devicePreferences: DevicePreferences): Promise<DevicePreferences>;
    insertDeviceLocalization(deviceLocalization: DeviceLocalization): Promise<DeviceLocalization>;


    updateCredentials(credentiats: Credentials): Promise<boolean>;


    deleteClientSessions(session: Session): Promise<boolean>;
}
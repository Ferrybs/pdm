import Credentials from "entity/credentials.entity";
import Device from "entity/device.entiy";
import DeviceLocalization from "entity/device.localization.entity";
import DevicePreferences from "entity/device.preferences.entity";
import Measure from "entity/measure.entity";
import Sessions from "entity/sessions.entity";
import TypeSession from "entity/type.session.entity";
import Client from "../entity/client.entity";

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
    findMeasuresByDevice(device: Device,start: Date,end: Date): Promise<Measure[]>;
    findDevicesBySessionId(sessionId: string): Promise<Device[]>;
    findDevicePreferencesByDevice(device: Device): Promise<DevicePreferences>;
    findDeviceLocalizationByDevice(device: Device): Promise<DeviceLocalization>;

    insertClient(client: Client): Promise<Client>;
    insertClientSessions(session: Sessions): Promise<Sessions>;
    insertDevice(device: Device): Promise<Device>;
    insertMeasure(measure: Measure): Promise<Measure>;
    insertTypeSession(typeSession: TypeSession): Promise<TypeSession>;
    insertDevicePreferences(devicePreferences: DevicePreferences): Promise<DevicePreferences>;
    insertDeviceLocalization(deviceLocalization: DeviceLocalization): Promise<DeviceLocalization>;

    updateCredentials(credentiats: Credentials): Promise<boolean>;

    deleteClientSessions(session: Sessions): Promise<boolean>;
}
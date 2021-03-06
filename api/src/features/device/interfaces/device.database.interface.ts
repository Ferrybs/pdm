import Client from "../../../features/client/entities/client.entity";
import Device from "../entities/device.entity";
import DeviceLocalization from "../entities/device.localization.entity";
import DevicePreferences from "../entities/device.preferences.entity";
import Measure from "../entities/measure.entity";
import Localization from "./localization";

export default interface DeviceDatabase{
    findDeviceById(id:string): Promise<Device>;
    findDevicesByClient(client:Client): Promise<Device[]>;
    findMeasuresByDevice(device: Device,start: Date,end: Date): Promise<Measure[]>;
    findDevicesBySessionId(sessionId: string): Promise<Device[]>;
    findDevicePreferencesByDevice(device: Device): Promise<DevicePreferences>;
    findDeviceLocalizationsByLocalization(x: Localization, y: Localization): Promise<DeviceLocalization[]>;
    findDeviceLocalizationByDeviceId(deviceId: string): Promise<DeviceLocalization>;
    findPreferencesAndLocalizationByDeviceIdList(idList: string[]): Promise<Device[]>

    insertDevice(device: Device): Promise<Device>;
    insertMeasure(measure: Measure): Promise<Measure>;
    insertDevicePreferences(devicePreferences: DevicePreferences): Promise<DevicePreferences>;
    insertDeviceLocalization(deviceLocalization: DeviceLocalization): Promise<DeviceLocalization>;

    deleteDeviceByDeviceId(id: string): Promise<boolean>;
}
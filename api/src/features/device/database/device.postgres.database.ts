import Device from "../entities/device.entity";
import DeviceLocalization from "../entities/device.localization.entity";
import devicePreferencesEntity from "../entities/device.preferences.entity";
import DevicePreferences from "../entities/device.preferences.entity";
import Measure from "../entities/measure.entity";
import Session from "../../../features/auth/entities/session.entity";
import DatabaseHttpException from "../../../exceptions/database.http.exception";
import { Between, DataSource, In } from "typeorm";
import DeviceDatabase from "../interfaces/device.database.interface";
import Client from "../../../features/client/entities/client.entity";
import Localization from "../interfaces/localization";
import DevicePreferencesDTO from "../dto/device.preferences.dto";
import DeviceLocalizationPreferencesQuery from "../interfaces/device.localiation.preferences.query";

export default class DevicePostgresDatabase implements DeviceDatabase{
    private _appDataSource: DataSource;

    constructor(dataSource: DataSource){
        this._appDataSource = dataSource;
    }
    public async findPreferencesAndLocalizationByDeviceIdList(idList: string[]): Promise<Device[]>{
        try {
            const devices: Device[] = [];
            const query: DeviceLocalizationPreferencesQuery[] = await this._appDataSource.manager.createQueryBuilder()
            .select()
            .from(Device,"d")
            .leftJoinAndSelect("d.localization","device_localization")
            .leftJoinAndSelect("d.preferences","device_preferences")
            .whereInIds(idList).execute();
            query.forEach((value)=>{
                const device = new Device();
                device.id = value.device_localization_deviceId;
                const localization = new DeviceLocalization();
                localization.latitude = value.device_localization_latitude;
                localization.longitude = value.device_localization_longitude;
                device.localization = localization;
                const preferences = new DevicePreferences();
                preferences.humidity = value.device_preferences_humidity ?? "0";
                preferences.luminosity = value.device_preferences_luminosity ?? "0";
                preferences.moisture = value.device_preferences_moisture ?? "0";
                preferences.temperature = value.device_preferences_temperature ?? "0";
                device.preferences = preferences;
                devices.push(device);
            })
            return devices;
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async findDeviceLocalizationByDeviceId(deviceId: string): Promise<DeviceLocalization> {
        try {
            const device = new Device();
            device.id = deviceId
            return await this._appDataSource.manager.findOne(
                DeviceLocalization,
                {where: {device}}
            );
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async findDeviceLocalizationsByLocalization(x: Localization, y: Localization): Promise<DeviceLocalization[]> {
        try {
            return await this._appDataSource.manager.find(
                DeviceLocalization,
                {where: {
                    latitude: Between(y.latitude,x.latitude),
                    longitude: Between(y.longitude,x.longitude)
                },relations: ["device"]}
            );
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async findDevicePreferencesByDevice(device: Device): Promise<DevicePreferences> {
        try {
            return await this._appDataSource.manager.findOne(
                DevicePreferences,
                {where: {
                    device: device 
                }
            });
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async findMeasuresByDevice(device: Device, start: Date, end: Date): Promise<Measure[]> {
        try {
            return await this._appDataSource.manager.find(
                Measure,
                {where: {
                    device: device,
                    date: Between(end,start) 
                },
                relations: ['type'],
                order: {
                    date: "ASC"
                }
            });
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }

    public async findDevicesBySessionId(sessionId: string): Promise<Device[]> {
        try {
            const session = new Session();
            session.id = sessionId;
            const client = await this._appDataSource.manager.findOne(
                Client, {where: {sessions: session}, 
                relations: ["devices"]});
            if (client) {
                return client.devices; 
            }
            return null;
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async findDevicesByClient(client: Client): Promise<Device[]> {
        try {
            const devices = await this._appDataSource.manager.find(
                Device,{where:{client: client}});
            return devices; 
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async findDeviceById(id: string): Promise<Device> {
        try {
            const device = await this._appDataSource.manager.findOne(
                Device,{where:{id: id}});
            return device; 
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }

    public async insertDeviceLocalization(deviceLocalization: DeviceLocalization): Promise<DeviceLocalization> {
        try {
            return await this._appDataSource.manager.save(deviceLocalization);
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        } 
    }
    public async insertDevicePreferences(devicePreferences: devicePreferencesEntity): Promise<devicePreferencesEntity> {
        try {
            return await this._appDataSource.manager.save(devicePreferences);
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        } 
    }
    public async insertMeasure(measure: Measure): Promise<Measure> {
        try {
            return await this._appDataSource.manager.save(measure);
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async insertDevice(device: Device): Promise<Device> {
        try {       
            return await this._appDataSource.manager.save(device);
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async deleteDeviceByDeviceId(id: string): Promise<boolean> {
        try {
            await this._appDataSource.createQueryBuilder()
            .delete().from(DeviceLocalization)
            .where("deviceId = :id",{id})
            .execute();

            await this._appDataSource.createQueryBuilder()
            .delete().from(DevicePreferences)
            .where("deviceId = :id",{id})
            .execute();

            await this._appDataSource.createQueryBuilder()
            .delete().from(Measure)
            .where("deviceId = :id",{id})
            .execute();

            const result =await this._appDataSource.manager.delete(Device,id);
            if(result.affected){
                return result.affected > 0;
            }
            return false;
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
}
import { instanceToInstance, plainToInstance } from "class-transformer";
import Device from "../entity/device.entity";
import DeviceDTO from "../dto/device.dto";
import DeviceFoundHttpException from "../exceptions/device.found.http.exception";
import Services from "./services";
import Client from "../entity/client.entity";
import ClientDTO from "../dto/client.dto";
import NotFoundHttpException from "../exceptions/not.found.http.exception";
import MeasureDTO from "../dto/measure.dto";
import TypeMeasureDTO from "../dto/type.measure.dto";
import MeasureQueryDTO from "../dto/measure.query.dto";
import DevicePreferencesDTO from "../dto/device.preferences.dto";
import DevicePreferences from "../entity/device.preferences.entity";
import DataStoreToken from "../interfaces/data.store.token.interface";
import DeviceLocalizationDTO from "../dto/device.localization.dto";
import DeviceLocalization from "../entity/device.localization.entity";
import MqttServer from "../mqtt/mqtt.server";
import MqttServerDTO from "../dto/mqtt.server.dto";
import validateEnv from "../utils/validateEnv";
import Database from "../interfaces/database.interface";

export default class DeviceService extends Services{
    private _mqtt: MqttServer;
    constructor(database: Database){
        super(database);
        this._mqtt = new MqttServer(database);
    }
    public  async addDevice(deviceDTO: DeviceDTO, clientDTO: ClientDTO): Promise<boolean>{
        if(await this.database.findDeviceById(deviceDTO.id)){
            throw new DeviceFoundHttpException(deviceDTO.id);
        }
        const device = plainToInstance(Device,deviceDTO);
        device.client = plainToInstance(Client,clientDTO);
        if (await this.database.insertDevice(device)) {
            return true;
        }
        return false;
    }
    public async addLocalization(deviceLocalizationDTO: DeviceLocalizationDTO,dataStoreToken: DataStoreToken): Promise<boolean>{
        const device = await this.isMatchSessionDevice(dataStoreToken.id,deviceLocalizationDTO.deviceDTO.id);
        if (device) {
            deviceLocalizationDTO.deviceDTO = undefined;

            const devicelocalization = new DeviceLocalization();
            devicelocalization.latitude = deviceLocalizationDTO.latitude;
            devicelocalization.longitude = deviceLocalizationDTO.longitude;
            devicelocalization.device = device;
            const deviceLocalization_old = await this.database.findDeviceLocalizationByDevice(device);
            if (deviceLocalization_old) {
                devicelocalization.id = deviceLocalization_old.id;
            }
            if(await this.database.insertDeviceLocalization(devicelocalization)){
                return true;
            }
        }
        return false;
    }
    public async addPreferences(devicePreferencesDTO: DevicePreferencesDTO,dataStoreToken: DataStoreToken): Promise<boolean>{
        const device = await this.isMatchSessionDevice(dataStoreToken.id,devicePreferencesDTO.deviceDTO.id);
        if(device){

            devicePreferencesDTO.deviceDTO = undefined;
            const devicePreferences = plainToInstance(DevicePreferences,devicePreferencesDTO);
            devicePreferences.device = device;
            const devicePreferences_old = await this.database.findDevicePreferencesByDevice(device);
            if (devicePreferences_old) {
                devicePreferences.id = devicePreferences_old.id;
            }
            if(await this.database.insertDevicePreferences(devicePreferences)){
                this._mqtt.postDevicePreferences(device.id,devicePreferencesDTO);
                return true;
            }
        }
        return false;

    }
    public async getDevices(clientId: string): Promise<DeviceDTO[]>{
        const client = new Client();
        client.id = clientId;
        if (client) {
            const deviceDTO: DeviceDTO[] = [];
            const devices = await this.database.findDevicesByClient(client);
            devices.forEach((device)=>{
                deviceDTO.push(plainToInstance(DeviceDTO,device));
            })
            return deviceDTO;
        }else{
            throw new NotFoundHttpException("CLIENT");
        }
    }
    public async isMatchSessionDevice(sessionId: string, deviceId: string): Promise<Device>{
        if (deviceId) {
            const devices = await this.database.findDevicesBySessionId(sessionId);
            if (devices) {
                return devices.find((device)=>{
                    if (device.id == deviceId) {
                        return device;
                    }
                });
            }
        }

        return null;  
        
    }

    public async getMeasures(measure_query: MeasureQueryDTO): Promise<MeasureDTO[]>{
        const device = new Device();
        device.id = measure_query.deviceId;
        const result = await this.database.findMeasuresByDevice(
            device, new Date(measure_query.start),
            new Date(measure_query.end));
        if(result.length >0){   
            const measureDTO: MeasureDTO[] = [];
            result.forEach((measure)=>{
                const result = new MeasureDTO();
                result.date = measure.date;
                result.value = measure.value;
                result.id = measure.id;
                result.typeDTO = plainToInstance(TypeMeasureDTO,measure.type);
                measureDTO.push(result);
            });
            return measureDTO;
        }else{
            throw new NotFoundHttpException("MEASURES");
        }
    }

    public async getPreferences(deviceDTO: DeviceDTO,dataStoreToken: DataStoreToken): Promise<DevicePreferencesDTO>{
        const device = await this.isMatchSessionDevice(dataStoreToken.id,deviceDTO.id);
        if(device){    
            const devicePreferences = await this.database.findDevicePreferencesByDevice(device);
            devicePreferences.device = undefined;
            devicePreferences.id = undefined;
            return plainToInstance(DevicePreferencesDTO,devicePreferences);
        }else{
            throw new NotFoundHttpException("MEASURES");
        }
    }
    public async getLocalization(deviceDTO: DeviceDTO,dataStoreToken: DataStoreToken): Promise<DeviceLocalizationDTO>{
        const device = await this.isMatchSessionDevice(dataStoreToken.id,deviceDTO.id);
        if(device){    
            const deviceLocalization = await this.database.findDeviceLocalizationByDevice(device);
            deviceLocalization.device = undefined;
            deviceLocalization.id = undefined;
            return plainToInstance(DeviceLocalizationDTO,deviceLocalization);
        }else{
            throw new NotFoundHttpException("MEASURES");
        }
    }
    public getMqttServer(): MqttServerDTO{
        const mqttDTO =  new MqttServerDTO();
        mqttDTO.server = validateEnv.MQTT_HOST;
        mqttDTO.user = validateEnv.MQTT_USER;
        mqttDTO.password = validateEnv.MQTT_PASS;
        mqttDTO.port = validateEnv.PORT.toString();
        return mqttDTO;
    }
}
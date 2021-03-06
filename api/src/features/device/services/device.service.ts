import { plainToInstance } from "class-transformer";
import Device from "../entities/device.entity";
import DeviceDTO from "../dto/device.dto";
import DeviceFoundHttpException from "../../../exceptions/device.found.http.exception";
import Services from "../../../services/services";
import ClientDTO from "../../../features/client/dto/client.dto";
import NotFoundHttpException from "../../../exceptions/not.found.http.exception";
import MeasureDTO from "../dto/measure.dto";
import TypeMeasureDTO from "../dto/type.measure.dto";
import MeasureQueryDTO from "../dto/measure.query.dto";
import DevicePreferencesDTO from "../dto/device.preferences.dto";
import DevicePreferences from "../entities/device.preferences.entity";
import DataStoreToken from "../interfaces/data.store.token.interface";
import DeviceLocalizationDTO from "../dto/device.localization.dto";
import DeviceLocalization from "../entities/device.localization.entity";
import MqttServer from "../../mqtt/mqtt.server";
import validateEnv from "../../../utils/validateEnv";
import { DataSource } from "typeorm";
import Measure from "../entities/measure.entity";
import TypeMeasure from "../entities/type.measure.entity";
import Client from "../../../features/client/entities/client.entity";
import MqttDTO from "../dto/mqtt.dto";
import ConfigsDTO from "../dto/device.configs";
import DeviceQueryLocalizationDTO from "../dto/device.query.localization.dto";
import Localization from "../interfaces/localization";
import DeviceMapDTO from "../dto/device.map.dto";
import PreferencesDTO from "../dto/preferences.dto";
import LocalizationDTO from "../dto/localization.dto";

export default class DeviceService extends Services{
    private _mqtt: MqttServer;
    constructor(dataSource: DataSource,mqttServer: MqttServer){
        super(dataSource);
        this._mqtt = mqttServer;
    }
    public  async addDevice(deviceDTO: DeviceDTO, clientDTO: ClientDTO): Promise<boolean>{
        if(await this._deviceDatabase.findDeviceById(deviceDTO.id)){
            throw new DeviceFoundHttpException(deviceDTO.id);
        }
        const device = plainToInstance(Device,deviceDTO);
        device.client = plainToInstance(Client,clientDTO);
        if (await this._deviceDatabase.insertDevice(device)) {
            return true;
        }
        return false;
    }
    public async addPreferences(devicePreferencesDTO: DevicePreferencesDTO,dataStoreToken: DataStoreToken): Promise<boolean>{
        const device = await this.isMatchSessionDevice(dataStoreToken.id,devicePreferencesDTO.deviceDTO.id);
        if(device){

            devicePreferencesDTO.deviceDTO = undefined;
            const devicePreferences = plainToInstance(DevicePreferences,devicePreferencesDTO);
            devicePreferences.device = device;
            const devicePreferences_old = await this._deviceDatabase.findDevicePreferencesByDevice(device);
            if (devicePreferences_old) {
                devicePreferences.id = devicePreferences_old.id;
            }
            if(await this._deviceDatabase.insertDevicePreferences(devicePreferences)){
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
            const devices = await this._deviceDatabase.findDevicesByClient(client);
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
            const devices = await this._deviceDatabase.findDevicesBySessionId(sessionId);
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
        const measureDTO: MeasureDTO[] = [];
        device.id = measure_query.deviceId;
        const result = await this._deviceDatabase.findMeasuresByDevice(
            device, new Date(measure_query.end),new Date(measure_query.start),);
        if(result.length >0){   
            result.forEach((measure)=>{
                const result = new MeasureDTO();
                result.date = measure.date;
                result.value = measure.value;
                result.id = measure.id;
                result.typeDTO = plainToInstance(TypeMeasureDTO,measure.type);
                measureDTO.push(result);
            });
        }
        return measureDTO;
    }

    public async addMeasure(measureDTO: MeasureDTO): Promise<boolean>{
        const measure = new Measure();
        measure.value = measureDTO.value;
        measure.date = measureDTO.date;
        measure.device = plainToInstance(Device,measureDTO.deviceDTO);
        measure.type = plainToInstance(TypeMeasure,measureDTO.typeDTO);
        const result =  await this._deviceDatabase.insertMeasure(measure);
        if(result){
            return true;
        }
        return false;
    }

    public async getPreferences(deviceDTO: DeviceDTO,dataStoreToken: DataStoreToken): Promise<DevicePreferencesDTO>{
        const device = await this.isMatchSessionDevice(dataStoreToken.id,deviceDTO.id);
        if(device){    
            const devicePreferences = await this._deviceDatabase.findDevicePreferencesByDevice(device);
            devicePreferences.device = undefined;
            devicePreferences.id = undefined;
            return plainToInstance(DevicePreferencesDTO,devicePreferences);
        }else{
            throw new NotFoundHttpException("MEASURES");
        }
    }

    public async getLocalization(deviceId: string,dataStoreToken: DataStoreToken): Promise<LocalizationDTO>{
        const device = await this.isMatchSessionDevice(dataStoreToken.id,deviceId);
        if(device){
            const localizationDTO = new LocalizationDTO;
            const deviceLocalization = await this._deviceDatabase.findDeviceLocalizationByDeviceId(device.id);
            localizationDTO.latitude = parseFloat(deviceLocalization.latitude.toString()) ;
            localizationDTO.longitude = parseFloat(deviceLocalization.longitude.toString());
            return localizationDTO;
        }else{
            throw new NotFoundHttpException("MEASURES");
        }
    }
    public async getMapLocalization(deviceQueryLocDTO: DeviceQueryLocalizationDTO,dataStoreToken: DataStoreToken): Promise<DeviceMapDTO[]>{
        const device = await this.isMatchSessionDevice(dataStoreToken.id,deviceQueryLocDTO.id);
        const km = 0.009009009;
        const result: DeviceMapDTO[] = []
        if(device){
            const x: Localization = {latitude: deviceQueryLocDTO.latitude -(km*(deviceQueryLocDTO.distance/2)),
                                     longitude: deviceQueryLocDTO.longitude -(km*(deviceQueryLocDTO.distance/2))};
            const y: Localization = {latitude: deviceQueryLocDTO.latitude +(km*(deviceQueryLocDTO.distance/2)),
                                    longitude: deviceQueryLocDTO.longitude +(km*(deviceQueryLocDTO.distance/2))};
            const deviceLocalizations = await this._deviceDatabase.findDeviceLocalizationsByLocalization(x,y);
            const deviceIdList = deviceLocalizations.map((value)=>{return value.device.id})
            const device = await this._deviceDatabase.findPreferencesAndLocalizationByDeviceIdList(deviceIdList);
            device.forEach(async (value)=> {
                const deviceMapDTO = new DeviceMapDTO();
                deviceMapDTO.deviceId = value.id;
                deviceMapDTO.localizationDTO = plainToInstance(LocalizationDTO,value.localization);
                deviceMapDTO.preferencesDTO = plainToInstance(PreferencesDTO,value.preferences);
                result.push(deviceMapDTO);
            });

            return result;
        }else{
            throw new NotFoundHttpException("MEASURES");
        }
    }
    public getConfigs(): ConfigsDTO{
        const mqttDTO =  new MqttDTO();
        mqttDTO.server = validateEnv.MQTT_HOST;
        mqttDTO.user = validateEnv.MQTT_USER;
        mqttDTO.password = validateEnv.MQTT_PASS;
        mqttDTO.port = validateEnv.MQTT_PORT.toString();
        const configsDTO = new ConfigsDTO()
        configsDTO.mqttDTO = mqttDTO;
        configsDTO.key = validateEnv.DEVICE_API;
        return configsDTO;
    }
    async deleteDevice(deviceId: string){
        try {
            return await this._deviceDatabase.deleteDeviceByDeviceId(deviceId);
        } catch (error) {
            throw new NotFoundHttpException("DEVICE");
        }

    }
}
import { plainToInstance } from "class-transformer";
import Device from "../entity/device.entiy";
import DeviceDTO from "../dto/device.dto";
import DeviceFoundHttpException from "../exceptions/device.found.http.exception";
import Services from "./services";
import Client from "../entity/client.entity";
import ClientDTO from "../dto/client.dto";
import NotFoundHttpException from "../exceptions/not.found.http.exception";
import MeasureDTO from "../dto/measure.dto";
import Measure from "../entity/measure.entity";
import TypeMeasure from "../entity/type.measure.entity";
import TypeMeasureDTO from "../dto/type.measure.dto";

export default class DeviceService extends Services{
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
    public async addMeasure(measureDTO: MeasureDTO): Promise<boolean>{
        
        const measure = new Measure();
        measure.value = measureDTO.value;
        measure.date = new Date();
        measure.device = plainToInstance(Device,measureDTO.deviceDTO);
        measure.type = plainToInstance(TypeMeasure,measureDTO.typeDTO);
        
        const result =  await this.database.insertMeasure(measure);
        if(result){
            return true;
        }
        return false;
    }

    public async isMatchSessionDevice(sessionId: string, deviceId: string): Promise<Device>{
        if (deviceId) {
            const devices = await this.database.findDevicesBySessionId(sessionId);
            return devices.find((device)=>{
                if (device.id == deviceId) {
                    return device;
                }
            });
        }else{
            return null;  
        }
        
    }

    public async getMeasures(deviceId: string): Promise<MeasureDTO[]>{
        const device = new Device();
        device.id = deviceId;
        const result = await this.database.findMeasuresByDevice(device);
        if(result.length >0){
            const measureDTO: MeasureDTO[] = [];
            result.forEach((measure)=>{
                const result = new MeasureDTO();
                result.date = measure.date;
                result.value = measure.value;
                result.id = measure.id;
                result.typeDTO = plainToInstance(TypeMeasureDTO,measure.type);
                result.deviceDTO = null;
                measureDTO.push(result);
            });
            return measureDTO;
        }else{
            throw new NotFoundHttpException("MEASURES");
        }
    }
}
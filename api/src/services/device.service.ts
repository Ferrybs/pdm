import { plainToInstance } from "class-transformer";
import Device from "../models/device.entiy";
import DeviceDTO from "../dto/device.dto";
import DeviceFoundHttpException from "../exceptions/device.found.http.exception";
import Services from "./services";
import Client from "../models/client.entity";
import ClientDTO from "../dto/client.dto";
import NotFoundHttpException from "../exceptions/not.found.http.exception";

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

    public async getDevices(id: string){
        const client = new Client()
        client.id = id;
        if (client) {

            return await this.database.findDevicesByClient(client);
        }else{
            throw new NotFoundHttpException("CLIENT");
        }
    }
}
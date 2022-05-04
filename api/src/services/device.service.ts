import ClientDTO from "../dto/client.dto";
import DeviceDTO from "../dto/device.dto";
import DeviceFoundHttpException from "../exceptions/device.found.http.exception";
import Services from "./services";

export default class DeviceService extends Services{
    public  async addDevice(deviceDTO: DeviceDTO, clientDTO: ClientDTO): Promise<boolean>{
        if(await this.database.findDeviceById(deviceDTO.id)){
            throw new DeviceFoundHttpException(deviceDTO.id);
        }
        deviceDTO.clientDTO = clientDTO;
        if (await this.database.insertDevice(deviceDTO)) {
            return true;
        }
        return false;
    }
}
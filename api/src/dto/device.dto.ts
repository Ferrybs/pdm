import { MaxLength, MinLength } from "class-validator";
import ClientDTO from "./client.dto";

export default class DeviceDTO {
    @MinLength(6,
        {message: "Device Id need to have at least 6 digits"})
    public id?: string;
    @MaxLength(10,{
        message: "Name need to have max 10 letters"
    })
    public name?: string;
    public clientDTO?: ClientDTO;
}
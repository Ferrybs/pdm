import { MaxLength, MinLength } from "class-validator";
import ClientDTO from "./client.dto";

export default class DeviceDTO {
    @MinLength(6)
    public id?: string;
    @MaxLength(23)
    public name?: string;
}
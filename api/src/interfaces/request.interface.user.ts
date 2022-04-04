import ClientDTO from "dto/client.dto";
import { Request } from "express";

export default interface RequestUser extends Request{
    client: ClientDTO
}
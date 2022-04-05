import ClientDTO from "dto/client.dto";
import { Request } from "express";

export default interface RequesWithClient extends Request{
    client: ClientDTO
}
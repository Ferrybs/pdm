import ClientDTO from "../dto/client.dto";
import TokenData from "./token.data.interface";

export default interface ClientStoreToken{
    clientDTO: ClientDTO
    accessToken: TokenData
}
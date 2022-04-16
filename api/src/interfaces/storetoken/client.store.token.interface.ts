import ClientDTO from "dto/client.dto";
import TokenData from "interfaces/token.data.interface";

export default interface ClientStoreToken{
    clientDTO: ClientDTO
    token: TokenData
}
import Client from "entity/client.entity";
import TokenData from "interfaces/token.data.interface";

export default interface ClientStoreToken{
    client: Client
    token: TokenData
}
import ClientDTO from "../dto/client.dto";
import StoreAllToken from "./store.all.token.interface";

export default interface ClientStoreToken{
    clientDTO: ClientDTO
    allToken: StoreAllToken
}
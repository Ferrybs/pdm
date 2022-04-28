import ClientDTO from "dto/client.dto";
import ClientStoreToken from "./client.store.token.interface";

export default interface SendMail{
    sendEmail(clientDTO: ClientDTO, token: string): Promise<boolean>;
}
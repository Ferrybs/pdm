import ClientStoreToken from "./client.store.token.interface";

export default interface SendMail{
    sendEmail(client: ClientStoreToken): Promise<boolean>;
}
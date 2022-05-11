import ClientDTO from "dto/client.dto";
export default interface SendMail{
    sendEmail(clientDTO: ClientDTO, token: string): Promise<boolean>;
}
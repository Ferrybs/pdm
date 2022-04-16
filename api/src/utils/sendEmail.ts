import * as nodemailer from "nodemailer";
import HttpException from "../exceptions/http.exceptions"
import clientStoreTokenInterface from "../interfaces/client.store.token.interface";
import SendMail from "../interfaces/send.email.interface";
import validateEnv from "./validateEnv";

export default class SendEmail implements SendMail{
    private _email: string;
    private _transporter: nodemailer.Transporter;

    constructor(){
        this._email = validateEnv.EMAIL_USER;
        try {
            this._transporter = nodemailer.createTransport({
                host: String(validateEnv.EMAIL_HOST),
                port: Number(validateEnv.EMAIL_PORT),
                secure: true,
                auth: {
                    user: validateEnv.EMAIL_USER,
                    pass: validateEnv.EMAIL_PASS
                },
                requireTLS: true,
            });
        } catch (error) {
            if (error instanceof HttpException){
                throw new HttpException(404, "Send Mail Error: " + error.message);
            } else{
                throw error;
            }
        }
    }

    async sendEmail(client: clientStoreTokenInterface): Promise<boolean>{
        try {
            const info = await this._transporter.sendMail({
                from: `Intelligent Garden Co.<${this._email}>`,
                to: client.clientDTO.credentialsDTO.email,
                subject: "Token ✔",
                text: client.token.token,
                html: `<b>${client.token.token}</b>`,
              });    

            if (nodemailer.getTestMessageUrl(info)) {
                return true;
            } else{
                return false;
            }

        } catch (error) {
            if (error instanceof HttpException){
                throw new HttpException(404, "Send Mail Error: " + error.message);
            } else{
                throw error;
            }
        }          
    }
}

import * as nodemailer from "nodemailer";
import validateEnv from "./validateEnv";

export default class SendEmail{
    private _email = validateEnv.EMAIL_USER;
    private _transporter = nodemailer.createTransport({
        host: String(validateEnv.EMAIL_HOST),
        port: Number(validateEnv.EMAIL_PORT),
        secure: true,
        auth: {
            user: validateEnv.EMAIL_USER,
            pass: validateEnv.EMAIL_PASS
        },
        requireTLS: true,
    });

    async get(){
        const info = await this._transporter.sendMail({
            from: `Intelligent Garden Co.<${this._email}>`,
            to: process.env.RECEIVER_EMAIL,
            subject: "Hello ✔",
            text: "Hello world?",
            html: "<b>Hello world?</b>",
          });

        return nodemailer.getTestMessageUrl(info);

    }
    async post(token: string, email: string){
        const info = await this._transporter.sendMail({
            from: `Intelligent Garden Co.<${this._email}>`,
            to: email,
            subject: "Token ✔",
            text: token,
            html: `<b>${token}</b>`,
          });

        return nodemailer.getTestMessageUrl(info);

    }
}

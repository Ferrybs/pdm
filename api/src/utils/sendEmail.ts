import * as nodemailer from "nodemailer";
import validateEnv from "./validateEnv";

export default class SendEmail{

    async get(){
        const testAccount = await nodemailer.createTestAccount();
        const transporter = nodemailer.createTransport({
            host: String(validateEnv.EMAIL_HOST),
            port: Number(validateEnv.EMAIL_PORT),
            secure: true,
            auth: {
                user: validateEnv.EMAIL_USER,
                pass: validateEnv.EMAIL_PASS
            },
            // requireTLS: true,
        });
    
        

        const info = await transporter.sendMail({
            from: "Intelligent Garden Co.<email@test.com>",
            to: process.env.RECEIVER_EMAIL,
            subject: "Hello ✔",
            text: "Hello world?",
            html: "<b>Hello world?</b>",
          });

        return nodemailer.getTestMessageUrl(info);

    }
    async post(token: string, email: string){
        const testAccount = await nodemailer.createTestAccount();
        const transporter = nodemailer.createTransport({
            host: String(validateEnv.EMAIL_HOST),
            port: Number(validateEnv.EMAIL_PORT),
            secure: true,
            auth: {
                user: validateEnv.EMAIL_USER,
                pass: validateEnv.EMAIL_PASS
            },
            requireTLS: true,
        });
    
        

        const info = await transporter.sendMail({
            from: "Intelligent Garden Co.<email@test.com>",
            to: email,
            subject: "Token ✔",
            text: token,
            html: `<b>${token}</b>`,
          });

        return nodemailer.getTestMessageUrl(info);

    }
}

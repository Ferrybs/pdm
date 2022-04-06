import * as nodemailer from "nodemailer";

export default class SendEmail{

    async get(){
        const testAccount = await nodemailer.createTestAccount();
        const transporter = nodemailer.createTransport({
            host: String(process.env.EMAIL_HOST),
            port: Number(process.env.EMAIL_PORT),
            secure: true,
            auth: {
                user: "coloque aqui o e-mail",
                pass: "coloque aqui a senha"
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
}

import AuthJwt from "../auth/auth.jwt";
import Crypto from "crypto";
import TypeSession from "../entity/type.session.entity";
import ChatbotTypeMessage from "../features/chatbot/entities/chatbot.type.message.entity";
import Email from "../features/email/interfaces/email.interface";
import NodeMail from "../features/email/node.email";
export default class Services {
    private _jwt = new AuthJwt();
    private _email: Email;
    constructor() {
        this._email = new NodeMail();
    }

    public get jwt(){
        return this._jwt;
    }

    public get email(){
        return this._email;
    }
    public generateSessionId(): string{
        const buffer = Crypto.randomBytes(64);
        return buffer.toString('hex');
      }
    public getLoginTypesession(){
        const typeSession = new TypeSession();
        typeSession.id ='1';
        typeSession.type = 'LOGIN';
        return typeSession;
    }
    public getRefreshTokenTypesession(){
        const typeSession = new TypeSession();
        typeSession.id ='3';
        typeSession.type = 'REFRESH_TOKEN';
        return typeSession;
    }
    public getResetPasswordTypesession(){
        const typeSession = new TypeSession();
        typeSession.id ='2';
        typeSession.type = 'RESET_PASSWORD';
        return typeSession;
    }
    public getClientTypeMessage(){
        const typeSession = new ChatbotTypeMessage();
        typeSession.id ='1';
        typeSession.type = 'CLIENT_MESSAGE';
        return typeSession;
    }
    public getBotTypeMessage(){
        const typeSession = new ChatbotTypeMessage();
        typeSession.id ='2';
        typeSession.type = 'BOT_MESSAGE';
        return typeSession;
    }
}
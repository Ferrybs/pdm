import SendEmail from "../utils/sendEmail";
import Database from "../interfaces/database.interface";
import PostgresDatabase from "../database/postgres.database";
import AuthJwt from "../auth/auth.jwt";
import SendMail from "../interfaces/send.email.interface";
import Crypto from "crypto";
import TypeSession from "../entity/type.session.entity";
export default class Services {
    private _database: Database;
    private _jwt: AuthJwt = new AuthJwt();
    private _email: SendMail;
    constructor() {
        this._database = new PostgresDatabase();
        this._email = new SendEmail();
    }

    public get database(){
        return this._database;
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
    public getResetPasswordTypesession(){
        const typeSession = new TypeSession();
        typeSession.id ='2';
        typeSession.type = 'RESET_PASSWORD';
        return typeSession;
    }
}
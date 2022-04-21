import SendEmail from "../utils/sendEmail";
import Database from "../interfaces/database.interface";
import PostgresDatabase from "../database/postgres.database";
import AuthJwt from "../auth/auth.jwt";
import SendMail from "../interfaces/send.email.interface";
import Crypto from "crypto";
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
}
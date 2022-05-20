import SendEmail from "../utils/sendEmail";
import Database from "../interfaces/database.interface";
import PostgresDatabase from "../database/postgres.database";
import AuthJwt from "../auth/auth.jwt";
import SendMail from "../interfaces/send.email.interface";
import Crypto from "crypto";
import TypeSession from "../entity/type.session.entity";
import MqttServer from "../mqtt/mqtt.server";
export default class Services {
    private _database: Database;
    private _mqtt: MqttServer; 
    private _jwt = new AuthJwt();
    private _email: SendMail;
    constructor() {
        const databese = new PostgresDatabase();
        this._database = databese;
        this._mqtt = new MqttServer(databese);
        this._email = new SendEmail();
    }
    public get mqtt(){
        return this._mqtt;
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
}
import SendEmail from "../utils/sendEmail";
import Database from "../interfaces/database.interface";
import PostgresDatabase from "../database/postgres.database";
import AuthJwt from "../auth/auth.jwt";
export default class Services {
    private _database: Database;
    private _jwt: AuthJwt = new AuthJwt();
    private _email: SendEmail;
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

    getEmail(){
        return this._email;
    }
}
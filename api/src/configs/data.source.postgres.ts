import { DataSource } from "typeorm";
import validateEnv from "../utils/validateEnv";
import Person from "../models/person.entity";
import Credentials from "../models/credentials.entity";
import Client from "../models/client.entity";
import Sessions from "../models/sessions.entity";
import Device from "../models/device.entiy";
import Measure from "../models/measure.entity";
import TypeMeasure from "../models/type.measure.entity";
import TypeSession from "../models/type.session.entity";

export default class PostgresDataSource{
    appDataSource: DataSource;
    constructor() {
        this.appDataSource= new DataSource({
            type: "postgres",
            url: validateEnv.DATABASE_URL,
            synchronize: true,
            logging: true,
            entities: [
                Credentials,Client,Person,Sessions,
                Device,Measure,TypeMeasure,TypeSession
              ],
            subscribers: [],
            migrations: [],
            extra: {
                ssl: {
                  rejectUnauthorized: false
                }
            }
        })
    }
}
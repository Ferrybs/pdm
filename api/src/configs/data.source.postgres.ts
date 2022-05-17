import { DataSource } from "typeorm";
import validateEnv from "../utils/validateEnv";
import Person from "../entity/person.entity";
import Credentials from "../entity/credentials.entity";
import Client from "../entity/client.entity";
import Sessions from "../entity/sessions.entity";
import Device from "../entity/device.entiy";
import Measure from "../entity/measure.entity";
import TypeMeasure from "../entity/type.measure.entity";
import TypeSession from "../entity/type.session.entity";

export default class PostgresDataSource{
    appDataSource: DataSource;
    constructor() {
        this.appDataSource= new DataSource({
            type: "postgres",
            url: validateEnv.DATABASE_URL,
            synchronize: true,
            logging: ["query"],
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
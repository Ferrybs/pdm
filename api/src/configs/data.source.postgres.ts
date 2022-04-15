import { DataSource } from "typeorm";
import validateEnv from "../utils/validateEnv";
import DataSourceDB from "../interfaces/data.source.interface";
import Person from "../entity/person.entity";
import Credentials from "../entity/credentials.entity";
import Client from "../entity/client.entity";

export default class PostgresDataSource{
    appDataSource: DataSource;
    constructor() {
        this.appDataSource= new DataSource({
            type: "postgres",
            url: validateEnv.DATABASE_URL,
            synchronize: true,
            logging: true,
            entities: [
                Credentials,Client,Person
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
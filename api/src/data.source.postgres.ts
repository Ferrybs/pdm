import { DataSource } from "typeorm";
import validateEnv from "./utils/validateEnv";
import DataSourceDB from "./interfaces/data.source.interface";
import Person from "./entity/person.entity";
import Credentials from "./entity/credentials.entity";
import Client from "./entity/client.entity";

export default class PostgresDataSource implements DataSourceDB {
    appDataSource: DataSource
    constructor() {
        this.appDataSource= new DataSource({
            type: "postgres",
            host: validateEnv.DATABASE_HOST,
            port: validateEnv.DATABASE_PORT,
            username: validateEnv.DATABASE_USER,
            password: validateEnv.DATABASE_PASS,
            database: validateEnv.DATABASE,
            synchronize: true,
            logging: true,
            entities: [
                Credentials,Client,Person,
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

//__dirname + '../**/*.entity{.ts,.js}'
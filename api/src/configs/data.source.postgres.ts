import { DataSource, EntitySchema } from "typeorm";
import validateEnv from "../utils/validateEnv";
import DataSourceDB from "../interfaces/data.source.interface";

export default class PostgresDataSource implements DataSourceDB {
    AppDataSource: DataSource
    constructor(entities: EntitySchema[]) {
        this.AppDataSource= new DataSource({
            type: "postgres",
            host: validateEnv.DATABASE_HOST,
            port: validateEnv.DATABASE_PORT,
            username: validateEnv.DATABASE_USER,
            password: validateEnv.DATABASE_PASS,
            database: validateEnv.DATABASE,
            synchronize: true,
            logging: true,
            entities: entities,
            subscribers: [],
            migrations: [],
        })
    }

}
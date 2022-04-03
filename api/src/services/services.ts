import PostgresDataSource from "configs/data.source.postgres";
import Credentials from "../entity/credentials.entity";
import Person from "entity/person.entity";
import User from "entity/user.entity";
import { EntitySchemaOptions } from "typeorm";
import DataSourceDB from "../interfaces/data.source.interface";
export default class Services {
    database: DataSourceDB
    constructor() {
        const entityOp = new EntitySchemaOptions
        this.database = new PostgresDataSource(
            [
                new User(entityOp),
                new Person(entityOp),
                new Credentials(entityOp)
            ]
        );
    }

    getDatabase(){
        return this.database.AppDataSource
    }
}
import { DataSource } from "typeorm";

export default interface DataSourceDB {
    appDataSource: DataSource
}
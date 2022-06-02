import { DataSource } from "typeorm";

export default class DevicePostgresDatabase {
    private _appDataSource: DataSource;

    constructor(dataSource: DataSource){
        this._appDataSource = dataSource;
    }

    
}
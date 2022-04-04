import PostgresDataSource from "../configs/data.source.postgres";
import Credentials from "../entity/credentials.entity";
import Person from "../entity/person.entity";
import User from "../entity/user.entity";
import { EntitySchemaOptions } from "typeorm";
import DataSourceDB from "../interfaces/data.source.interface";
import UserDTO from "../dto/user.dto";
export default class Services {
    dataSource: DataSourceDB
    constructor() {
        this.dataSource = new PostgresDataSource();
    }

    getDatabase(){
        return this.dataSource.appDataSource
    }
    createUser(userData: UserDTO){
        const userRepository = this.getDatabase().getRepository(User);
        return userRepository.create({
            person: userData.personDTO,
            credentials: userData.credentialsDTO
        })
    }
}
import clientDto from "dto/client.dto";
import credentialsDto from "dto/credentials.dto";
import Credentials from "entity/credentials.entity";
import Person from "entity/person.entity";
import Database from "interfaces/database/database.interface";
import Client from "entity/client.entity";
import ClientWithThatEmailAlreadyExistsException from "exceptions/client.email.exist";
import HttpException from "exceptions/http.exceptions";
import { DataSource, EntityManager } from "typeorm";
import PostgresDataSource from "configs/data.source.postgres";

export default class PostgresDatabase implements Database{
    private _appDataSource: DataSource;
    constructor(){
        const dataSource = new PostgresDataSource();
        this._appDataSource = dataSource.appDataSource;
    }
    async updateCredentials(credentialsDTO: credentialsDto) {
        try {
            await this._appDataSource.initialize();
            const credResul = this._appDataSource.manager.create(Credentials,credentialsDTO);
            await this._appDataSource.manager.update(Credentials,credResul.email,credResul);
            await this._appDataSource.destroy();
        } catch (error) {
            throw( new HttpException(404,error.message));
        }
    }
    async findClient(credentialsDTO: credentialsDto): Promise<Client> {
      try {
            await this._appDataSource.initialize();
            const credentialsClient = await this._appDataSource.manager.findOne(Credentials,
            {where: 
                {
                email: credentialsDTO.email
                }
            });
            await this._appDataSource.initialize();
            const client = await this._appDataSource.manager.findOne(
            Client,{where:{credentials: credentialsClient}, relations: ['credentials', 'person']});
            await this._appDataSource.destroy();
            return client;

        } catch (error) {
            throw( new HttpException(404,error.message));
        }

    }
    async insertClient(clientDTO: clientDto): Promise<Client>{
        try {
            await this._appDataSource.initialize();
            if(
                await this._appDataSource.manager.findOneBy(Credentials,{email: clientDTO.credentialsDTO.email})
            ){
                this._appDataSource.destroy();
                throw new ClientWithThatEmailAlreadyExistsException(clientDTO.credentialsDTO.email);
            }
            const person = this._appDataSource.manager.create(Person,clientDTO.personDTO);
            const cred = this._appDataSource.manager.create(Credentials,clientDTO.credentialsDTO);
            const client = new Client();
            client.credentials = cred;
            client.person = person;
            await this._appDataSource.manager.save(person);
            await this._appDataSource.manager.save(cred);
            await this._appDataSource.manager.save(client);
            await this._appDataSource.destroy();
            return client;
        } catch (error) {
            await this._appDataSource.destroy();
            throw (new HttpException(404,error.message));
        }
    }
}
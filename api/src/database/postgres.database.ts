import credentialsDto from "../dto/credentials.dto";
import Credentials from "../entity/credentials.entity";
import Person from "../entity/person.entity";
import Database from "../interfaces/database.interface";
import Client from "../entity/client.entity";
import { DataSource, DeleteResult, UpdateResult } from "typeorm";
import PostgresDataSource from "../configs/data.source.postgres";
import Sessions from "../entity/sessions.entity";
import ClientDTO from "../dto/client.dto";
import DatabaseHttpException from "../exceptions/database.http.exception";
import EmailFoundHttpException from "../exceptions/email.found.http.exception";
import NotFoundHttpException from "../exceptions/not.found.http.exception";

export default class PostgresDatabase implements Database{
    private _appDataSource: DataSource;
    constructor(){
        const dataSource = new PostgresDataSource();
        this._appDataSource = dataSource.appDataSource;
        this.initializeDatabase();
    }
    private async initializeDatabase(){
        await this._appDataSource.initialize();
    }

    public async updateCredentials(credentialsDTO: credentialsDto): Promise<boolean>{
        try {
            const credentials = this._appDataSource.manager.create(Credentials,credentialsDTO);
            const result: UpdateResult = await this._appDataSource.manager.update(Credentials,credentials.email,credentials);
            if(result.affected != null && result.affected>0){
                return true;
            }
            return false
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async findClientById(id: string): Promise<Client>{
        try {
            const client = await this._appDataSource.manager.findOne(
                Client,{where:{id: id}, relations: ['credentials', 'person','sessions']});
            return client;
        } catch (error) {
            throw (new DatabaseHttpException(error.message));

        }
    }
    public async findClientBySessionId(sessionId: string): Promise<Client>{
        var client: Client;
        try {
            const session = await this._appDataSource.manager.findOne(Sessions,{where:{id:sessionId}})
            if(session){
                client = await this._appDataSource.manager.findOne(Client,
                    {where:{sessions: session}, 
                    relations: ['credentials', 'person','sessions']});
            }
            return client;
            
        } catch (error) {
            throw (new DatabaseHttpException(error.message));
        }
    }
    public async findClientByEmail(credentialsDTO: credentialsDto): Promise<Client>{
        var client: Client;
        try {
            const credentialsClient = await this._appDataSource.manager.findOne(Credentials,
            {where: 
                {
                email: credentialsDTO.email
                }
            });
            if (credentialsClient) {
                client = await this._appDataSource.manager.findOne(
                Client,{where:{credentials: credentialsClient}, 
                relations: ['credentials', 'person','sessions']});
            }
        
            return client;
        } catch (error) {
            throw(new DatabaseHttpException(error.message));
        }
      }
    public async insertClient(clientDTO: ClientDTO): Promise<Client>{
        try {
            if(
                await this.findClientByEmail(clientDTO.credentialsDTO)
            ){
                throw new EmailFoundHttpException(clientDTO.credentialsDTO.email);
            }
        } catch (error) {
            throw error;
        }
        try {
            const person = this._appDataSource.manager.create(Person,clientDTO.personDTO);
            const cred = this._appDataSource.manager.create(Credentials,clientDTO.credentialsDTO);
            const client = new Client();
            client.credentials = cred;
            client.person = person;
            await this._appDataSource.manager.save(person);
            await this._appDataSource.manager.save(cred);
            return await this._appDataSource.manager.save(client);
        } catch (error) {
            throw (new DatabaseHttpException(error.message));
        }
    }
    public async deleteClientSessions(session: Sessions): Promise<boolean> {
        try {
            const result: DeleteResult = await this._appDataSource.manager.delete(Sessions,session.id);
            if(result.affected != null && result.affected>0) {
                return true;
            }
            return false;
        } catch (error) {
            throw (new DatabaseHttpException(error.message));
        }
    }
    public async insertClientSessions(sessions: Sessions): Promise<Sessions> {
        try {
            const result = await this._appDataSource.manager.save(sessions);
            return result;
        } catch (error) {
            throw (new DatabaseHttpException(error.message));
        }
    }
}
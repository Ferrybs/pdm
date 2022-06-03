import Credentials from "../entity/credentials.entity";
import Database from "../interfaces/database.interface";
import Client from "../entity/client.entity";
import { Between, DataSource, DeleteResult, UpdateResult } from "typeorm";
import PostgresDataSource from "../configs/data.source.postgres";
import DatabaseHttpException from "../exceptions/database.http.exception";
import Device from "../entity/device.entity";
import TypeSession from "../entity/type.session.entity";
import Session from "../entity/session.entity";
import Measure from "../entity/measure.entity";
import devicePreferencesEntity from "../entity/device.preferences.entity";
import DeviceLocalization from "../entity/device.localization.entity";
import DevicePreferences from "../entity/device.preferences.entity";
import ChatbotSession from "../features/chatbot/entity/chatbot.session.entity";
import ChatbotMessage from "../features/chatbot/entity/chatbot.message.entity";
import ChatbotPostgresDatabase from "features/chatbot/database/chatbot.postgres.database";
import DevicePostgresDatabase from "features/device/database/device.postgres.database";

export default class PostgresDatabase implements Database{

    constructor(){
        super(new PostgresDataSource()._appDataSource);
    }
    

    
    
    public async findClientById(id: string): Promise<Client>{
        try {
            const client = await this._appDataSource.manager.findOne(
                Client,{where:{id: id}, relations: ['credentials', 'person']});
            return client;
        } catch (error) {
            throw (new DatabaseHttpException(error.message));

        }
    }
    public async findClientBySessionId(sessionId: string): Promise<Client>{
        var client: Client;
        try {
            const session = await this._appDataSource.manager.findOne(Session,{where:{id:sessionId}});
            if(session){
                client = await this._appDataSource.manager.findOne(Client,
                    {where:{sessions: session}, 
                    relations: ['credentials', 'person']});
            }
            return client;
            
        } catch (error) {
            throw (new DatabaseHttpException(error.message));
        }
    }
    public async findClientByEmail(credentials: Credentials): Promise<Client>{
        var client: Client;
        try {
            const credentialsClient = await this._appDataSource.manager.findOne(Credentials,
            {where: 
                {
                email: credentials.email
                }
            });
            if (credentialsClient) {
                client = await this._appDataSource.manager.findOne(
                Client,{where:{credentials: credentialsClient}, 
                relations: ['credentials', 'person']});
            }
        
            return client;
        } catch (error) {
            throw(new DatabaseHttpException(error.message));
        }
      }
    public async insertClient(client: Client): Promise<Client>{
        try {
            await this._appDataSource.manager.save(client.person);
            await this._appDataSource.manager.save(client.credentials);
            return await this._appDataSource.manager.save(client);
        } catch (error) {
            throw (new DatabaseHttpException(error.message));
        }
    }
    
}
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

    public async findChatbotSessionBySessionId(id: string): Promise<ChatbotSession> {
        try {
            return await this._appDataSource.manager.findOne(
                ChatbotSession,
                {where: {
                    id: id 
                }
            });
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }

    public async findChatbotSessionById(id: string): Promise<ChatbotSession> {
        try {
            return await this._appDataSource.manager.findOne(
                ChatbotSession,
                {where: {
                    id
                },
                relations: ['client'],
            });
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }

    public async findChatbotMessagesBySessionId(id: string): Promise<ChatbotMessage[]> {
        try {
            const chatbotSession = new ChatbotSession();
            chatbotSession.id = id;

            return await this._appDataSource.manager.find(
                ChatbotMessage,
                {where: {
                    chatbotSession: chatbotSession,
                },
                relations: ['type'],
                order: {
                    date: "ASC"
                }
            });
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }

    public async findDeviceLocalizationByDevice(device: Device): Promise<DeviceLocalization> {
        try {
            return await this._appDataSource.manager.findOne(
                DeviceLocalization,
                {where: {
                    device: device 
                }
            });
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async findDevicePreferencesByDevice(device: Device): Promise<DevicePreferences> {
        try {
            return await this._appDataSource.manager.findOne(
                DevicePreferences,
                {where: {
                    device: device 
                }
            });
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async findMeasuresByDevice(device: Device, start: Date, end: Date): Promise<Measure[]> {
        try {
            return await this._appDataSource.manager.find(
                Measure,
                {where: {
                    device: device,
                    date: Between(end,start) 
                },
                relations: ['type'],
                order: {
                    date: "ASC"
                }
            });
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async findSessionBySessionId(id: string): Promise<Session> {
        try {
            return await this._appDataSource.manager.findOne(
                Session,
                {where:{id: id}, 
                relations:['type']
            });
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async findSessionsByClientid(id: string): Promise<Session[]> {
        try {
            const client = new Client()
            client.id = id;
            return await this._appDataSource.manager.find(
                Session,
                {where:{client: client}, 
                relations:['type']
            });
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async findSessionsByClient(client: Client): Promise<Session[]> {
        try {
            return await this._appDataSource.manager.find(
                Session,
                {where:{client: client}, 
                relations:['type']
            });
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async insertDeviceLocalization(deviceLocalization: DeviceLocalization): Promise<DeviceLocalization> {
        try {
            return await this._appDataSource.manager.save(deviceLocalization);
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        } 
    }
    public async insertDevicePreferences(devicePreferences: devicePreferencesEntity): Promise<devicePreferencesEntity> {
        try {
            return await this._appDataSource.manager.save(devicePreferences);
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        } 
    }
    public async insertMeasure(measure: Measure): Promise<Measure> {
        try {
            return await this._appDataSource.manager.save(measure);
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async insertTypeSession(typeSession: TypeSession): Promise<TypeSession> {
        try {
            return await this._appDataSource.manager.save(typeSession);
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }

    public async insertChatbotSession(chatbotSession: ChatbotSession): Promise<ChatbotSession> {
        try {
            return await this._appDataSource.manager.save(chatbotSession);
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }

    public async insertChatbotMessage(chatbotMessage: ChatbotMessage): Promise<ChatbotMessage>{
        try {
            return await this._appDataSource.manager.save(chatbotMessage);
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }

    public async findTypeSession(typeSession: TypeSession): Promise<TypeSession> {
        try {
            return await this._appDataSource.manager.findOne(
                TypeSession,
                {where: {type: typeSession.type},relations: ['sessions']});
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async insertDevice(device: Device): Promise<Device> {
        try {       
            return await this._appDataSource.manager.save(device);
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async findDevicesBySessionId(sessionId: string): Promise<Device[]> {
        try {
            const client = await this.findClientBySessionId(sessionId);
            if (client) {
                const devices = await this._appDataSource.manager.find(
                    Device,{where:{client: client}});
                return devices; 
            }
            return null;
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async findDevicesByClient(client: Client): Promise<Device[]> {
        try {
            const devices = await this._appDataSource.manager.find(
                Device,{where:{client: client}});
            return devices; 
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
    public async findDeviceById(id: string): Promise<Device> {
        try {
            const device = await this._appDataSource.manager.findOne(
                Device,{where:{id: id}});
            return device; 
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }

    public async updateCredentials(credentials: Credentials): Promise<boolean>{
        try {
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
    public async deleteClientSessions(session: Session): Promise<boolean> {
        try {
            const result: DeleteResult = await this._appDataSource.manager.delete(Session,session.id);
            if(result.affected != null && result.affected>0) {
                return true;
            }
            return false;
        } catch (error) {
            throw (new DatabaseHttpException(error.message));
        }
    }
    public async insertClientSessions(session: Session): Promise<Session> {
        try {
            const result = await this._appDataSource.manager.save(session);
            return result;
        } catch (error) {
            throw (new DatabaseHttpException(error.message));
        }
    }
}
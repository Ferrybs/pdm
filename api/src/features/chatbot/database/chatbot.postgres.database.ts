import PostgresDataSource from "configs/data.source.postgres";
import PostgresDatabase from "database/postgres.database";
import DatabaseHttpException from "exceptions/database.http.exception";
import { DataSource, DeleteResult } from "typeorm";
import ChatbotMessage from "../entity/chatbot.message.entity";
import ChatbotSession from "../entity/chatbot.session.entity";
import ChatbotDatabase from "../interfaces/chatbot.database.interface";

export default class ChatbotPostgresDatabase implements ChatbotDatabase{
    private _appDataSource: DataSource;

    constructor(dataSource: DataSource){
        this._appDataSource = dataSource;
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

    public async deleteAllMessagesBySessionId(sessionId: string): Promise<boolean> {
        try {
            const chatbotSession = new ChatbotSession();
            chatbotSession.id = sessionId;
            
            const result: DeleteResult =  await this._appDataSource.manager.delete(ChatbotSession, chatbotSession);
            return result?.affected >= 1;
        } catch (error) {
            throw( new DatabaseHttpException(error.message));
        }
    }
}
import { DataSource } from "typeorm";
import validateEnv from "../utils/validateEnv";
import Person from "../entity/person.entity";
import Credentials from "../entity/credentials.entity";
import Client from "../entity/client.entity";
import Session from "../entity/session.entity";
import Device from "../features/device/entity/device.entity";
import Measure from "../features/device/entity/measure.entity";
import TypeMeasure from "../features/device/entity/type.measure.entity";
import TypeSession from "../entity/type.session.entity";
import DeviceLocalization from "../features/device/entity/device.localization.entity";
import DevicePreferences from "../features/device/entity/device.preferences.entity";
import ChatbotSession from "../features/chatbot/entity/chatbot.session.entity";
import ChatbotMessage from "../features/chatbot/entity/chatbot.message.entity";
import ChatbotTypeMessage from "../features/chatbot/entity/chatbot.type.message.entity";

export default class PostgresDataSource{
    _appDataSource: DataSource;
    constructor() {
        this.initialize();
        this.initializeDatabase();
    }
    private initialize(){
        this._appDataSource= new DataSource({
            type: "postgres",
            url: validateEnv.DATABASE_URL,
            synchronize: true,
            logging: ["query"],
            entities: [
                Credentials,Client,Person,Session,
                Device,Measure,TypeMeasure,TypeSession,
                DeviceLocalization, DevicePreferences,
                ChatbotSession,ChatbotMessage, ChatbotTypeMessage
              ],
            subscribers: [],
            extra: {
                ssl: {
                  rejectUnauthorized: false
                }
            }
        });
    }
    private async initializeDatabase(){
        await this._appDataSource.initialize();
    }
}
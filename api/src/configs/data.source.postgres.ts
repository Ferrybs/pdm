import { DataSource } from "typeorm";
import validateEnv from "../utils/validateEnv";
import Person from "../entity/person.entity";
import Credentials from "../entity/credentials.entity";
import Client from "../entity/client.entity";
import Session from "../entity/session.entity";
import Device from "../entity/device.entiy";
import Measure from "../entity/measure.entity";
import TypeMeasure from "../entity/type.measure.entity";
import TypeSession from "../entity/type.session.entity";
import DeviceLocalization from "../entity/device.localization.entity";
import DevicePreferences from "../entity/device.preferences.entity";
import ChatbotSession from "../entity/chatbot.session.entity";
import ChatbotMessage from "../entity/chatbot.message.entity";

export default class PostgresDataSource{
    appDataSource: DataSource;
    constructor() {
        this.appDataSource= new DataSource({
            type: "postgres",
            url: validateEnv.DATABASE_URL,
            synchronize: true,
            logging: ["query"],
            entities: [
                Credentials,Client,Person,Session,
                Device,Measure,TypeMeasure,TypeSession,
                DeviceLocalization, DevicePreferences,
                ChatbotSession,ChatbotMessage
              ],
            subscribers: [],
            extra: {
                ssl: {
                  rejectUnauthorized: false
                }
            }
        })
    }
}
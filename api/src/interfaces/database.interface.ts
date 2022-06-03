import Credentials from "entity/credentials.entity";
import Device from "features/device/entity/device.entity";
import DeviceLocalization from "features/device/entity/device.localization.entity";
import DevicePreferences from "features/device/entity/device.preferences.entity";
import Measure from "features/device/entity/measure.entity";
import Session from "../entity/session.entity";
import TypeSession from "../entity/type.session.entity";
import Client from "../entity/client.entity";
import ChatbotSession from "../features/chatbot/entity/chatbot.session.entity";
import ChatbotMessage from "../features/chatbot/entity/chatbot.message.entity";
import ChatbotDatabase from "features/chatbot/interfaces/chatbot.database.interface";

export default interface Database extends ChatbotDatabase{

    findClientById(id: string): Promise<Client>;
    findClientBySessionId(id: string): Promise<Client>;
    findClientByEmail(credentials: Credentials): Promise<Client>;
    

    insertClient(client: Client): Promise<Client>;
}
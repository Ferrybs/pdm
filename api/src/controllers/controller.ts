import AuthService from "../features/auth/service/auth.service";
import HomeService from "../features/home/service/home.service";
import DeviceService from "../features/device/services/device.service";
import ChatbotService from "../features/chatbot/service/chatbot.service";
import { DataSource } from "typeorm";
import ClientService from "../features/client/service/client.service";

export default class Controller{
    homeService: HomeService;
    clientService: ClientService;
    authService: AuthService;
    deviceService: DeviceService;
    chatbotService: ChatbotService;
    constructor(appDataSource: DataSource){
        this.homeService = new HomeService(appDataSource);
        this.clientService = new ClientService(appDataSource);
        this.authService = new AuthService(appDataSource);
        this.deviceService = new DeviceService(appDataSource);
        this.chatbotService = new ChatbotService(appDataSource);
    }
}
import AuthService from "../services/auth.service";
import HomeService from "../services/home.service";
import ClientService from "../features/client/service/client.service";
import DeviceService from "../services/device.service";
import ChatbotService from "../features/chatbot/service/chatbot.service";
import { DataSource } from "typeorm";

export default class Controller{
    homeService: HomeService;
    clientService: ClientService;
    authService: AuthService;
    deviceService: DeviceService;
    chatbotService: ChatbotService;
    constructor(appDataSource: DataSource){
        this.homeService = new HomeService();
        this.clientService = new ClientService(appDataSource);
        this.authService = new AuthService(appDataSource);
        this.deviceService = new DeviceService(appDataSource);
        this.chatbotService = new ChatbotService(appDataSource);
    }
}
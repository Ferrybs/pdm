import AuthService from "../services/auth.service";
import HomeService from "../services/home.service";
import ClientService from "../services/client.service";
import DeviceService from "../services/device.service";
import ChatbotService from "../features/chatbot/service/chatbot.service";
import Database from "../interfaces/database.interface";

export default class Controller{
    homeService: HomeService;
    clientService: ClientService;
    authService: AuthService;
    deviceService: DeviceService;
    chatbotService: ChatbotService;
    constructor(database: Database){
        this.homeService = new HomeService(database);
        this.clientService = new ClientService(database);
        this.authService = new AuthService(database);
        this.deviceService = new DeviceService(database);
        this.chatbotService = new ChatbotService(database);
    }
}
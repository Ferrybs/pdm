import AuthService from "../services/auth.service";
import HomeService from "../services/home.service";
import ClientService from "../services/client.service";
import DeviceService from "../services/device.service";
import ChatbotService from "../chatbot/chatbot.service";

export default class Controller{
    homeService: HomeService = new HomeService();
    clientService: ClientService = new ClientService();
    authService: AuthService = new AuthService();
    deviceService: DeviceService = new DeviceService();
    chatbotService: ChatbotService = new ChatbotService();
}
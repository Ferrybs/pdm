import AuthService from "../services/auth.service";
import HomeService from "../services/home.service";
import ClientService from "../services/client.service";

export default class Controller{
    homeService: HomeService = new HomeService();
    clientService: ClientService = new ClientService();
    authService: AuthService = new AuthService();
}
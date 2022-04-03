import AuthService from "../services/auth.service";
import HomeService from "../services/home.service";
import UserService from "../services/user.service";

export default class Controller{
    homeService: HomeService = new HomeService();
    userService: UserService = new UserService();
    authService: AuthService = new AuthService();
}
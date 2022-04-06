import { Request, Response } from "express";
import SendEmail from "../utils/sendEmail";
import HomeService from "../services/home.service"
import Controller from "./controller";

export default class HomeController extends Controller{
    private service: HomeService = new HomeService();
    private email: SendEmail = new SendEmail();
    
    public async get(request: Request, response: Response){
        response.send(this.service.getHome());
    }

    public async getSendEmail(request: Request, response: Response){
        response.send(await this.email.get());
    }
    
}
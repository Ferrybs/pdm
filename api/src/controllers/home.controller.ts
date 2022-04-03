import { Request, Response } from "express";
import Controller from "../interfaces/controller.interface";
import HomeService from "../services/home.service"

export default class HomeController implements Controller{
    private service: HomeService = new HomeService();

    public async get(request: Request, response: Response){
        response.send(this.service.getHome());
    }
    
}
import { Request, Response } from "express";
import HomeService from "../services/home.service"

export default class HomeController{
    private service: HomeService;
    constructor(){
        this.service  = new HomeService();
    }
    public async get(request: Request, response: Response){
        response.send(this.service.getHome());
    }
    
}
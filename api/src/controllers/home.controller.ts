import express, { Router } from "express";
import Controller from "../interfaces/controller.interface";
import HomeService from "../services/home.service"

export default class HomeController implements Controller{
    public path : string = '/';
    public router : Router = express.Router();
    private service: HomeService = new HomeService();

    constructor(){
        this.initializeRoutes();
    }

    private initializeRoutes() {
        this.router.get(this.path,this.service.getHome);
    }

    
}
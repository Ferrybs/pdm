import HomeController from "../controllers/home.controller";
import express, { Router } from "express";


export default class HomeRoutes {
    public path : string = '/';
    public router : Router = express.Router();
    private controller: HomeController;

    constructor(){
        this.controller = new HomeController();
        this.initializeRoutes();
    }
    
    private initializeRoutes() {
            this.router.get(this.path,this.controller.get);
    }

}
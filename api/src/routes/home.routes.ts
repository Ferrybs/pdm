import HomeController from "../controllers/home.controller";
import express, { Router } from "express";
import Database from "../interfaces/database.interface";
import { DataSource } from "typeorm";


export default class HomeRoutes {
    public path : string = '';
    public router : Router = express.Router();
    private _controller: HomeController;

    constructor(database: DataSource){
        this._controller = new HomeController(database);
        this.initializeRoutes();
    }
    
    private initializeRoutes() {
        this.router.get(this.path,this._controller.get.bind(this._controller));
    }

}
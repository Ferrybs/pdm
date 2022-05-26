import express, { Router } from "express";
import Database from "../interfaces/database.interface";
import ChatbotController from "./chatbot.controller";

export default class ChatbotRoutes {
    public path : string = '/message/text/send';
    public router : Router = express.Router();
    private _controller: ChatbotController;

    constructor(database: Database){
        this._controller = new ChatbotController(database);
        this.initializeRoutes();
    }
    
    private initializeRoutes() {
        console.log("entrei na rota");
        this.router.post(this.path,this._controller.sendText.bind(this._controller));
    }
}
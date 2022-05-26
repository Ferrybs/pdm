import express, { Router } from "express";
import ChatbotController from "./chatbot.controller";

export default class ChatbotRoutes {
    public path : string = '/message/text/send';
    public router : Router = express.Router();
    private controller: ChatbotController = new ChatbotController();

    constructor(){
        this.initializeRoutes();
    }
    
    private initializeRoutes() {
        console.log("entrei na rota");
        this.router.post(this.path,this.controller.sendText.bind(this.controller));
    }
}
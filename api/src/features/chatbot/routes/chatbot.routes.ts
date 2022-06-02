import express, { Router } from "express";
import AuthMiddleware from "../../../middlewares/auth.middleware";
import Database from "../../../interfaces/database.interface";
import ChatbotController from "../controller/chatbot.controller";
import Auth from "../../../interfaces/auth.interface";
import ValidationMiddleware from "../../../middlewares/validation.middleware";
import Validation from "../../../interfaces/validation.interface";

export default class ChatbotRoutes {
    public path : string = '/chatbot';
    public router : Router = express.Router();
    private _controller: ChatbotController;
    private _authMiddleware: Auth = new AuthMiddleware();
    private _validationMiddleware: Validation = new ValidationMiddleware();

    constructor(database: Database){
        this._controller = new ChatbotController(database);
        this.initializeRoutes();
    }
    
    private initializeRoutes() {
        this.router.post(`${this.path}/send/text`,
            this._validationMiddleware.chatbotMessage(),
            this._authMiddleware.verifyAccesToken(),
            this._controller.sendText.bind(this._controller));

        this.router.get(
            `${this.path}/:id`,
            this._authMiddleware.verifyAccesToken(),
            this._controller.getAllMessagesSession.bind(this._controller));
    }
}
import express, { Router } from "express";
import AuthMiddleware from "../middlewares/auth.middleware";
import ClientController from "../controllers/client.controller";


export default class ClientRoutes {
    public path : string = '/client';
    public router : Router = express.Router();
    private _controller = new ClientController();
    private _authMiddleware = new AuthMiddleware();;

    constructor(){
        this.initializeRoutes();
    }
    
    private initializeRoutes() {
        this.router.get(
            `${this.path}`,
            this._authMiddleware.verifyAccesToken(),
            this._controller.getClient.bind(this._controller)
            );
    }

}
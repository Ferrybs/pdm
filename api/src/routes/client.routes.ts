import express, { Router } from "express";
import DeviceController from "../controllers/device.controler";
import ValidationMiddleware from "../middlewares/validation.middleware";
import AuthMiddleware from "../middlewares/auth.middleware";
import ClientController from "controllers/client.controller";


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
            this._authMiddleware.verifyByBody(),
            this._controller.getClient.bind(this._controller)
            );
    }

}
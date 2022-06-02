import express, { Router } from "express";
import AuthJwtMiddleware from "../middleware/auth.client.jwt.middleware";
import { DataSource } from "typeorm";
import ClientController from "../controller/client.controller";
import AuthMiddleware from "../interface/auth.client.middleware.interface";


export default class ClientRoutes {
    public path : string = '/client';
    public router : Router = express.Router();
    private _controller;
    private _authMiddleware: AuthMiddleware = new AuthJwtMiddleware();;

    constructor(appDataSource: DataSource){
        this._controller = new ClientController(appDataSource);
        this.initializeRoutes();
    }
    
    private initializeRoutes() {
        this.router.get(
            `${this.path}`,
            this._authMiddleware.verifyAccessToken(),
            this._controller.getClient.bind(this._controller)
            );
    }

}
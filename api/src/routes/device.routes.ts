import express, { Router } from "express";
import DeviceController from "../controllers/device.controler";
import ValidationMiddleware from "../middlewares/validation.middleware";
import AuthMiddleware from "../middlewares/auth.middleware";
import AuthController from "controllers/auth.controller";


export default class DeviceRoutes {
    public path : string = '/device';
    public router : Router = express.Router();
    private _controller: DeviceController = new DeviceController();
    private _validationMiddleware = new ValidationMiddleware();;
    private _authMiddleware = new AuthMiddleware();;

    constructor(){
        this.initializeRoutes();
    }
    
    private initializeRoutes() {
        this.router.post(
            `${this.path}`,
            this._validationMiddleware.device(),
            this._authMiddleware.verifyAccesToken(),
            this._controller.addDevice.bind(this._controller)
            );
        this.router.get(
            `${this.path}`,
            this._validationMiddleware.device(),
            this._authMiddleware.verifyAccesToken(),
            this._controller.getDevices.bind(this._controller)
            );
    }

}
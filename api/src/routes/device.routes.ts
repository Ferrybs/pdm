import express, { Router } from "express";
import DeviceController from "../controllers/device.controller";
import ValidationMiddleware from "../middlewares/validation.middleware";
import AuthMiddleware from "../middlewares/auth.middleware";
import Validation from "../interfaces/validation.interface";
import Auth from "../interfaces/auth.interface";


export default class DeviceRoutes {
    public path : string = '/device';
    public router : Router = express.Router();
    private _controller: DeviceController = new DeviceController();
    private _validationMiddleware: Validation = new ValidationMiddleware();;
    private _authMiddleware: Auth = new AuthMiddleware();;

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
            this._authMiddleware.verifyAccesToken(),
            this._controller.getDevices.bind(this._controller)
            );
        this.router.post(
            `${this.path}/measure`,
            this._authMiddleware.verifyAccesToken(),
            this._validationMiddleware.measureQuery(),
            this._controller.getMeasures.bind(this._controller)
            );
        this.router.post(
            `${this.path}/preferences`,
            this._authMiddleware.verifyAccesToken(),
            this._validationMiddleware.preferences(),
            this._controller.addPreferences.bind(this._controller)
            );
        this.router.get(
            `${this.path}/preferences`,
            this._authMiddleware.verifyAccesToken(),
            this._validationMiddleware.device(),
            this._controller.getPreferences.bind(this._controller)
            );
        this.router.post(
            `${this.path}/localization`,
            this._authMiddleware.verifyAccesToken(),
            this._validationMiddleware.localization(),
            this._controller.addLocatization.bind(this._controller)
            );
        this.router.get(
            `${this.path}/localization`,
            this._authMiddleware.verifyAccesToken(),
            this._validationMiddleware.device(),
            this._controller.getLocalization.bind(this._controller)
            );
        this.router.get(
            `${this.path}/mqtt-server`,
            this._authMiddleware.verifyAccesToken(),
            this._controller.getMqttServer.bind(this._controller)
            );
    }

}
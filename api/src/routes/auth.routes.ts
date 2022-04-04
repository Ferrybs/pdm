// post signup
// get login
// patch forgot password
import express, { Router } from "express";
import AuthController from "../controllers/auth.controller"
import validationMiddleware from "../middlewares/validation.middleware";
import ValidationMiddleware from "../middlewares/validation.middleware";

export default class AuthRoutes {
    public path : string = '/';
    public router : Router = express.Router();
    private controller: AuthController = new AuthController();

    constructor(){
        this.initializeRoutes();
    }
    
    private initializeRoutes() {
            this.router.post(
                `${this.path}register`,
                new ValidationMiddleware().client(),
                this.controller.register.bind(this.controller)
                );
            this.router.get(
                `${this.path}login`,
                new validationMiddleware().credentials(),
                this.controller.login.bind(this.controller)
                );
    }

}
// post signup
// get login
// patch forgot password
import express, { Router } from "express";
import authMiddleware from "../middlewares/auth.middleware";
import AuthController from "../controllers/auth.controller"
import validationMiddleware from "../middlewares/validation.middleware";
import ValidationMiddleware from "../middlewares/validation.middleware";

export default class AuthRoutes {
    public path : string = '/auth';
    public router : Router = express.Router();
    private controller: AuthController = new AuthController();

    constructor(){
        this.initializeRoutes();
    }
    
    private initializeRoutes() {
            this.router.post(
                `${this.path}/register`,
                new ValidationMiddleware().client(),
                this.controller.register.bind(this.controller)
                );
            this.router.get(
                `${this.path}/login`,
                new validationMiddleware().credentials(),
                this.controller.login.bind(this.controller)
                );
            this.router.post(
                `${this.path}/forgot-password`,
                new validationMiddleware().credentials(),
                this.controller.recoverySendEmail.bind(this.controller)
            )
            this.router.get(
                `${this.path}/forgot-password`,
                new authMiddleware(this.controller.clientService).verify(),
                this.controller.recoverypassword.bind(this.controller)
            )
            this.router.patch(
                `${this.path}/forgot-password`,
                new authMiddleware(this.controller.clientService).verify(),
                this.controller.recoverypassword.bind(this.controller)
            )
    }

}
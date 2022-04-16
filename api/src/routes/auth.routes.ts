// post signup
// get login
// patch forgot password
import express, { Router } from "express";
import AuthController from "../controllers/auth.controller"
import ValidationMiddleware from "../middlewares/validation.middleware";
import Validation from "../interfaces/validation.interface";
import Auth from "../interfaces/auth.interface";
import AuthMiddleware from "../middlewares/auth.middleware";
export default class AuthRoutes {
    public path : string = '/auth';
    public router : Router = express.Router();
    private _controller: AuthController;
    private _validationMiddleware: Validation;
    private _authMiddleware: Auth;

    constructor(){
        this._validationMiddleware = new ValidationMiddleware();
        this._controller = new AuthController();
        this._authMiddleware = new AuthMiddleware(this._controller.clientService);
        this.initializeRoutes();
    }
    
    private initializeRoutes() {
            this.router.post(
                `${this.path}/register`,
                this._validationMiddleware.client(),
                this._controller.register.bind(this._controller)
                );
            this.router.get(
                `${this.path}/login`,
                this._validationMiddleware.credentials(),
                this._controller.login.bind(this._controller)
                );
            this.router.post(
                `${this.path}/forgot-password`,
                this._validationMiddleware.credentials(),
                this._controller.recoverySendEmail.bind(this._controller)
            )
            this.router.get(
                `${this.path}/forgot-password`,
                this._authMiddleware.verifyByheader(),
                this._controller.recoverypassword.bind(this._controller)
            )
            this.router.patch(
                `${this.path}/forgot-password`,
                this._authMiddleware.verifyByheader(),
                this._controller.recoverypassword.bind(this._controller)
            )
    }

}
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
        this._authMiddleware = new AuthMiddleware();
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
            this.router.get(
                `${this.path}/refresh`,
                this._authMiddleware.refreshToken(),
                this._controller.refresh.bind(this._controller)
                );
            this.router.post(
                `${this.path}/reset-password`,
                this._validationMiddleware.email(),
                this._controller.resetPasswordSendEmail.bind(this._controller)
            )
            this.router.get(
                `${this.path}/reset-password/:token`,
                this._authMiddleware.verifyByParam(),
                this._controller.resetPasswordPage.bind(this._controller)
            )
            this.router.post(
                `${this.path}/change-password`,
                this._authMiddleware.verifyByBody(),
                this._validationMiddleware.password(),
                this._controller.changePasswordPage.bind(this._controller)
            )
    }

}
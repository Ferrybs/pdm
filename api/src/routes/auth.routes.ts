import express, { Router } from "express";
import AuthController from "../controllers/auth.controller"
import ValidationMiddleware from "../middlewares/validation.middleware";
import Validation from "../interfaces/validation.interface";
import Auth from "../interfaces/auth.interface";
import AuthMiddleware from "../middlewares/auth.middleware";
import Database from "../interfaces/database.interface";
export default class AuthRoutes {
    public path : string = '/auth';
    public router : Router = express.Router();
    private _controller: AuthController;
    private _validationMiddleware: Validation;
    private _authMiddleware: Auth;

    constructor(database: Database){
        this._validationMiddleware = new ValidationMiddleware();
        this._controller = new AuthController(database);
        this._authMiddleware = new AuthMiddleware();
        this.initializeRoutes();
    }
    
    private initializeRoutes() {
            this.router.post(
                `${this.path}/register`,
                this._validationMiddleware.register(),
                this._controller.register.bind(this._controller)
                );
            this.router.post(
                `${this.path}/login`,
                this._validationMiddleware.login(),
                this._controller.login.bind(this._controller)
                );
            this.router.post(
                `${this.path}/refresh-token`,
                this._authMiddleware.verifyAccesToken(),
                this._controller.newRefreshToken.bind(this._controller)
                );
            this.router.get(
                `${this.path}/access-token`,
                this._authMiddleware.verifyRefreshToken(),
                this._controller.newAccessToken.bind(this._controller)
                );
            this.router.post(
                `${this.path}/reset-password`,
                this._validationMiddleware.email(),
                this._controller.resetPasswordSendEmail.bind(this._controller)
            )
            this.router.get(
                `${this.path}/reset-password/:token`,
                this._authMiddleware.verifyPasswordReset(),
                this._controller.resetPasswordPage.bind(this._controller)
            )
            this.router.post(
                `${this.path}/change-password`,
                this._authMiddleware.verifyPasswordReset(),
                this._validationMiddleware.password(),
                this._controller.changePasswordPage.bind(this._controller)
            )
            this.router.get(
                `${this.path}/sessions`,
                this._authMiddleware.verifyAccesToken(),
                this._controller.getSessions.bind(this._controller)
            )
    }

}
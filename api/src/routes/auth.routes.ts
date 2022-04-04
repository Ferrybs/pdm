// post signup
// get login
// patch forgot password
import express, { Router } from "express";
import AuthController from "../controllers/auth.controller"

export default class AuthRoutes {
    public path : string = '/';
    public router : Router = express.Router();
    private controller: AuthController = new AuthController();

    constructor(){
        this.initializeRoutes();
    }
    
    private initializeRoutes() {
            this.router.post(`${this.path}register`,this.controller.register.bind(this.controller));
    }

}
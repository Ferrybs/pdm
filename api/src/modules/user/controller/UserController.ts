import express, { Router } from "express";
import Controller from "../../interfaces/Controller";

export default class UserController implements Controller{
    public path : string = '/user';
    public router : Router = express.Router();

    constructor(){
    }

    private initializeRoute(){
    }

    
}
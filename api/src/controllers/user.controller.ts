import express, { Router } from "express";

export default class UserController{
    public path : string = '/user';
    public router : Router = express.Router();

    constructor(){
    }

    private initializeRoute(){
    }

    
}
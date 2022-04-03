import express, { Router } from "express";
import Controller from "../interface/controller.interface";

export default class UserController implements Controller{
    public path : string = '/user';
    public router : Router = express.Router();

    constructor(){
    }

    private initializeRoute(){
    }

    
}
import { Request, Response } from "express";
import HomeService from "../services/home.service"
import Controller from "./controller";

export default class HomeController extends Controller{
    
    public async get(request: Request, response: Response){
        console.log(request.body);
        response.send(this.homeService.getHome());
    } 
}
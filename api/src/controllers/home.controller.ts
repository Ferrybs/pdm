import { Request, Response } from "express";
import HomeService from "../services/home.service"
import Controller from "./controller";

export default class HomeController extends Controller{
    private service: HomeService = new HomeService();
    
    public async get(request: Request, response: Response){
        console.log(request.body);
        response.send(this.service.getHome());
    }
    public home(request: Request, response: Response){
        const data = {
            ok: true,
            message: "Password redefined with success!" 
        }
        response.render('pages/redefine-password',{data});
    }  
}
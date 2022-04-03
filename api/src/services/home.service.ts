import { Request, Response } from "express";
import Services from "./services"
export default class HomeService extends Services{

    public getHome = () => {
        return {
            ok: true
        };
      }
}
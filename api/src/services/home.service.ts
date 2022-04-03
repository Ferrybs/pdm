import { Request, Response } from "express";
import Services from "./services"
export default class HomeService extends Services{

    public getHome = async (request: Request, response: Response) => {
        response.send({
            ok: true
        });
      }
}
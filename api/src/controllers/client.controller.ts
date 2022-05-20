import HttpException from "../exceptions/http.exceptions";
import { Response } from "express";
import RequestWithToken from "../interfaces/request.token.interface";
import Controller from "./controller";
import HttpData from "interfaces/http.data.interface";

export default class ClientController extends Controller{
    public async getClient(request: RequestWithToken, response: Response){
        if (request.error) {
          const httpData: HttpData = { ok: false, message: request.error};
            response.status(400).send(httpData);
          }else{
            try {
              const dataStoreToken  = request.dataStoreToken;
              const clientDTO = await this.clientService.getClientBySessionId(dataStoreToken.id);
              response.status(200).send({ok: true,clientDTO});
            } catch (error) {
              if(error instanceof(HttpException)){
                response.status(error.status).send(error.data);
              }else{
                response.status(500).send({ ok: false, message: error.message});
              }
            
            }
          }
    } 
}
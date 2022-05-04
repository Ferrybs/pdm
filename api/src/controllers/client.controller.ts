import HttpException from "exceptions/http.exceptions";
import { Response } from "express";
import RequestWithToken from "interfaces/request.token.interface";
import Controller from "./controller";

export default class ClientController extends Controller{
    public async getClient(request: RequestWithToken, response: Response){
        if (request.error) {
            response.status(400).send({ ok: false, message: request.error});
          }else{
            try {
              const dataStoreToken  = request.dataStoreToken;
              const result = await this.clientService.getClientBySessionId(dataStoreToken.id);
              response.status(200).send({ok: true,result});
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
import { NextFunction, Request, Response } from "express";
import Controller from "./controller";
import ClientDTO from "../dto/client.dto";
import HttpException from "../exceptions/http.exceptions";
import CredentialsDTO from "dto/credentials.dto";
import RequesWithClient from "interfaces/request.client.interface";

export default class AuthController extends Controller{

  public async register(request: Request, response: Response, next: NextFunction){
    const clientData: ClientDTO = request.body;
    try {
      const {
        cookie,
        client
      } = await this.authService.register(clientData);
      response.setHeader('Set-Cookie', [cookie]);
      response.send(client);
    } catch (error) {
      if(error instanceof HttpException){
        response.status(error.status).send(error.data);
      }else{
        response.status(error.status).send({ ok: false, message: error.message});
      }
    }
  }

  public async login(request: Request, response: Response, next: NextFunction) {
    const credentialsData: CredentialsDTO = request.body;
    try {
      const {
        cookie,
        result
      } = await this.authService.login(credentialsData);
      response.setHeader('Set-Cookie', [cookie]);
      response.send(result);
    } catch (error) {
      if(error instanceof HttpException){
        response.status(error.status).send(error.data);
      }else{
        response.status(error.status).send({ ok: false, message: error.message});
      }
    }
  }
  public async recoverypassword(request: RequesWithClient, response: Response, next: NextFunction){
    try {
      const body = request.body as ClientDTO;
      const client = request.client
      client.credentialsDTO.password = body.credentialsDTO.password
      this.authService.recoverypassword(client);
      response.status(200).send({ok:true});
    } catch (error) {
      if(error instanceof HttpException){
        response.status(error.status).send(error.data);
      }else{
        response.status(400).send({ ok: false, message: error.message});
      }
    }
  }
}
import { NextFunction, Request, Response } from "express";
import Controller from "./controller";
import ClientDTO from "../dto/client.dto";
import HttpException from "../exceptions/http.exceptions";
import CredentialsDTO from "../dto/credentials.dto";
import RequesWithClient from "../interfaces/request.client.interface";

export default class AuthController extends Controller{

  public async register(request: Request, response: Response, next: NextFunction){
    try {
      const clientData: ClientDTO = request.body;
      const clientStoreToken = await this.authService.register(clientData);
      response.send(clientStoreToken);
    } catch (error) {
      if(error instanceof HttpException){
        response.status(error.status).send(error.data);
      }else{
        response.status(404).send({ ok: false, message: error.message});
      }
    }
  }
  public refresh(request: RequesWithClient, response: Response, next: NextFunction){
    try {
      const clientDTO = request.client;
      const tokenData = this.authService.refresh(clientDTO);
      response.send(tokenData);
    } catch (error) {
      response.status(404).send({ ok: false, message: error.message});
    }
  }

  public async login(request: Request, response: Response, next: NextFunction) {
    try {
      const credentialsData: CredentialsDTO = request.body;
      const clientStoreToken = await this.authService.login(credentialsData);
      response.send(clientStoreToken);
    } catch (error) {
      if(error instanceof HttpException){
        response.status(error.status).send(error.data);
      }else{
        response.status(404).send({ ok: false, message: error.message});
      }
    }
  }
  public async recoverypassword(request: RequesWithClient, response: Response, next: NextFunction){
    try {
      response.send(request.body)
    } catch (error) {
      if(error instanceof HttpException){
        response.status(error.status).send(error.data);
      }else{
        response.status(404).send({ ok: false, message: error.message});
      }
    }
  }
  public resetPasswordPage(request: RequesWithClient, response: Response, next: NextFunction) {
    try {
      const clientDTO = request.client;
      const data = {
        name: clientDTO.personDTO.name
      }
      response.render('pages/redefine-password',{data});
    } catch (error) {
      response.status(404).send({ ok: false, message: error.message});
    }
  }
  public async resetPasswordSendEmail(request: Request, response: Response){
    try {
      const body = request.body as CredentialsDTO;
      if (body) {
        await this.authService.sendEmail(body);
        response.status(200).send({ok:true});
      }
    } catch (error) {
      if(error instanceof HttpException){
        response.status(error.status).send(error.data);
      }else{
        response.status(404).send({ ok: false, message: error.message});
      }
    }
  }
}
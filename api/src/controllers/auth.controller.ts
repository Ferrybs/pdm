import { NextFunction, Request, Response } from "express";
import Controller from "./controller";
import ClientDTO from "../dto/client.dto";
import HttpException from "../exceptions/http.exceptions";
import CredentialsDTO from "../dto/credentials.dto";
import RequesWithClient from "../interfaces/request.client.interface";

export default class AuthController extends Controller{

  public async register(request: Request, response: Response, next: NextFunction){
    const clientData: ClientDTO = request.body;
    try {
      const {
        token,
        client
      } = await this.authService.register(clientData);
      response.setHeader('Authorization', 'Bearer '+token.token);
      response.send(client);
    } catch (error) {
      if(error instanceof HttpException){
        response.status(error.status).send(error.data);
      }else{
        response.status(400).send({ ok: false, message: error.message});
      }
    }
  }

  public async login(request: Request, response: Response, next: NextFunction) {
    try {
      const credentialsData: CredentialsDTO = request.body;
      const {
        token,
        result
      } = await this.authService.login(credentialsData);
      const bearer = `Bearer ${token.token}`;
      response.setHeader("Authorization",bearer);
      response.send(result);
    } catch (error) {
      if(error instanceof HttpException){
        response.status(error.status).send(error.data);
      }else{
        response.status(400).send({ ok: false, message: error.message});
      }
    }
  }
  public async recoverypassword(request: RequesWithClient, response: Response, next: NextFunction){
    try {
      const body = request.body as CredentialsDTO;
      const client = request.client
      client.credentialsDTO.password = body.password
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
  public async recoverySendEmail(request: Request, response: Response){
    try {
      const body = request.body as CredentialsDTO;
      await this.authService.sendEmail(body);
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
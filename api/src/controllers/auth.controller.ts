import { NextFunction, Request, Response } from "express";
import Controller from "./controller";
import ClientDTO from "../dto/client.dto";
import HttpException from "../exceptions/http.exceptions";
import CredentialsDTO from "../dto/credentials.dto";
import RequesWithToken from "interfaces/request.token.interface";

export default class AuthController extends Controller{

  public async register(request: Request, response: Response){
    try {
      const clientDTO: ClientDTO = request.body;
      const clientStoreToken = await this.authService.register(clientDTO);
      response.send(clientStoreToken);
    } catch (error) {
      if(error instanceof HttpException){
        response.status(error.status).send(error.data);
      }else{
        response.status(404).send({ ok: false, message: error.message});
      }
    }
  }
  public async refresh(request: RequesWithToken, response: Response, next: NextFunction){
    try {
      const data = request.dataStoreToken;
      const tokenData = await this.authService.refresh(data.id);
      response.status(200).send(tokenData);
    } catch (error) {
      response.status(404).send({ ok: false, message: error.message});
    }
  }

  public async login(request: Request, response: Response, next: NextFunction) {
    try {
      const credentialsData: CredentialsDTO = request.body;
      const allToken = await this.authService.login(credentialsData);
      const clientDTO = await this.clientService.getClientByEmail(credentialsData);
      clientDTO.credentialsDTO.password = null;
      response.send({allToken,clientDTO});
    } catch (error) {
      if(error instanceof HttpException){
        response.status(error.status).send(error.data);
      }else{
        response.status(404).send({ ok: false, message: error.message});
      }
    }
  }
  public async changePasswordPage(request: RequesWithToken, response: Response, next: NextFunction){
    let message: string;
    let token: string;
    let name: string = "User";
    let result: boolean = false;
    try {
      const password: string = request.body.pass;
      const dataStoreToken = request.dataStoreToken;
      name = request.body.name;
      token = request.body.token;
      const clientDTO = await this.clientService.getClientBySessionId(dataStoreToken.id);
      if (clientDTO) {
        await this.authService.updateClientSessionByClientId(clientDTO.id);
        const credentialsDTO = clientDTO.credentialsDTO;
        credentialsDTO.password = password;
        result = await this.clientService.updateCredentials(credentialsDTO);
      }else{
        message = " This link is not invalid any more."
      }
    } catch (error) {
      message = error.message;
    }
    try {
      const data = {
        ok: result,
        token: token,
        message: result ? "Password Changed" : message,
        name:name
      }
      response.render('pages/redefinePassword',{data});
    } catch (error) {
      if(error instanceof HttpException){
        response.status(error.status).send(error.data);
      }else{
        response.status(404).send({ ok: false, message: error.message});
      }
    }
  }
  public async resetPasswordPage(request: RequesWithToken, response: Response, next: NextFunction) {
    try {
      const dataStoreToken = request.dataStoreToken;
      const clientDTO = await this.clientService.getClientBySessionId(dataStoreToken.id);
      if(clientDTO){
        const data = {
          token: request.params.token,
          name: clientDTO.personDTO.name
        }
        response.render('pages/redefinePassword',{data});
      }else{
        response.render('pages/invalidLink');
      }
    } catch (error) {
      response.render('pages/invalidLink',{message: error.message});
    }
  }
  public async resetPasswordSendEmail(request: Request, response: Response){
    try {
      const body: CredentialsDTO = request.body;
      if (body) {
        body.password = null;
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
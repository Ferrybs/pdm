import { NextFunction,Response } from "express";
import Controller from "./controller";
import ClientDTO from "../dto/client.dto";
import CredentialsDTO from "../dto/credentials.dto";
import RequesWithToken from "../interfaces/request.token.interface";
import { validate } from "class-validator";
import RequestWithError from "../interfaces/request.error.interface";
import HttpException from "../exceptions/http.exceptions";

export default class AuthController extends Controller{

  public async getSessions(request: RequesWithToken, response: Response){
    if (request.error) {
      response.status(400).send({ ok: false, message: request.error});
    }else{
      try {
        const dataStoreToken = request.dataStoreToken;
        const result = await this.authService.getSessions(dataStoreToken.id);
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

  public async register(request: RequestWithError, response: Response){
    if (request.error) {
      response.status(400).send({ ok: false, message: request.error});
    }else{
      try {
        const clientDTO: ClientDTO = request.body;
        const result = await this.authService.register(clientDTO);
        response.status(200).send({ok: result});
      } catch (error) {
        if(error instanceof(HttpException)){
          response.status(error.status).send(error.data);
        }else{
          response.status(500).send({ ok: false, message: error.message});
        }
      
      }
    }
  }
  public async newRefreshToken(request: RequesWithToken, response: Response, next: NextFunction){
    if (request.error) {
      response.status(400).send({ ok: false, message: request.error});
    }else{
      try {
        const data = request.dataStoreToken;
        const refreshToken = await this.authService.getNewRefreshToken(data);
        response.status(200).send({ok: true,refreshToken});
      } catch (error) {
        if(error instanceof(HttpException)){
          response.status(error.status).send(error.data);
        }else{
          response.status(500).send({ ok: false, message: error.message});
        }
      }
    }
  }
  public async newAccessToken(request: RequesWithToken, response: Response, next: NextFunction){
    if (request.error) {
      response.status(400).send({ ok: false, message: request.error});
    }else{
      try {
        const data = request.dataStoreToken;
        const tokenData = await this.authService.getNewAccessToken(data.id);
        if (tokenData) {
          response.status(200).send({ok: true,tokenData});
        }else{
          response.status(401).send({ ok: false, message: "Not Found"});
        }
      } catch (error) {
        if(error instanceof(HttpException)){
          response.status(error.status).send(error.data);
        }else{
          response.status(500).send({ ok: false, message: error.message});
        }
      }
    }
  }

  public async login(request: RequestWithError, response: Response, next: NextFunction) {
    if (request.error) {
      response.status(400).send({ ok: false, message: request.error});
    }else{
      try {
        const credentialsData: CredentialsDTO = request.body;
        const tokenData = await this.authService.login(credentialsData);
        const clientDTO = await this.clientService.getClientByEmail(credentialsData);
        clientDTO.credentialsDTO.password = null;
        response.status(200).send({ok:true,clientDTO,tokenData});
      } catch (error) {
        if(error instanceof(HttpException)){
          response.status(error.status).send(error.data);
        }else{
          response.status(500).send({ ok: false, message: error.message});
        }
      }
    }
  }
  public async changePasswordPage(request: RequesWithToken, response: Response, next: NextFunction){
    let message: string;
    let token: string;
    let name: string = "User";
    let result: boolean = false;
    if (request.error) {
      response.render('pages/invalidLink',{message: request.error});
    }else{
      try {
        const password: string = request.body.pass;
        const dataStoreToken = request.dataStoreToken;
        const clientDTO = await this.clientService.getClientBySessionId(dataStoreToken.id);
        if (clientDTO) {
          name = clientDTO.personDTO.name;
          token = request.body.token;

          await this.authService.updateClientSessionsByClientId(clientDTO.id);
          const credentialsDTO = clientDTO.credentialsDTO;
          credentialsDTO.password = password;
          await validate(credentialsDTO);
          result = await this.clientService.updateCredentials(credentialsDTO);
          try {
            const data = {
              ok: result,
              token: token,
              message: result ? "Password Changed" : message,
              name:name
            }
            response.render('pages/redefinePassword',{data});
          } catch (error) {
            response.status(500).send({ ok: false, message: error.message});
          }
        }else{
          response.render('pages/invalidLink');
        }
      } catch (error) {
        response.render('pages/invalidLink',{message: error.message});
      }
    }
  }
  public async resetPasswordPage(request: RequesWithToken, response: Response, next: NextFunction) {
    if (request.error) {
      response.render('pages/invalidLink',{message: request.error});
    }else{
      try {
        const dataStoreToken = request.dataStoreToken;
        const clientDTO = await this.clientService.getClientBySessionId(dataStoreToken.id);
        if(clientDTO){
          const data = {
            token: request.params.token,
            name: clientDTO.personDTO.name
          }
          response.render('pages/redefinePassword',{data});
        }
      } catch (error) {
        response.render('pages/invalidLink',{message: error.message});
      }
    }
  }
  public async resetPasswordSendEmail(request: RequestWithError, response: Response){
    if (request.error){
      response.status(400).send({ ok: false, message: request.error});
    }else{
      try {
        const body: CredentialsDTO = request.body;
        if (body) {
          await this.authService.sendEmail(body);
          response.status(200).send({ok:true});
        }
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
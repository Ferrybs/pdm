import { NextFunction, Request, Response } from "express";
import RequestUser from "interfaces/request.interface.user";
import Controller from "./controller";
import jwt from "jsonwebtoken";
import DataStoreToken from "interfaces/data.store.token.interface";
import ClientDTO from "../dto/client.dto";
import HttpException from "../exceptions/http.exceptions";
import console from "console";
import CredentialsDTO from "dto/credentials.dto";

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

  // public async authMiddleware(request: RequestUser, response: Response, next: NextFunction) {
  //       const cookies = request.cookies;
  //       if (cookies && cookies.Authorization) {
  //         const secret = process.env.JWT_SECRET;
  //         try {
  //           const verificationResponse = jwt.verify(cookies.Authorization, secret) as DataStoreToken;
  //           const id = verificationResponse.id;
  //           const user = this.userService.getUser(id)
  //         }catch(error){}
  //       }
  //   }
}
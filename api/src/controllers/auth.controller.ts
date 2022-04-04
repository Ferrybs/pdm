import { NextFunction, Request, Response } from "express";
import RequestUser from "interfaces/request.interface.user";
import Controller from "./controller";
import jwt from "jsonwebtoken";
import DataStoreToken from "interfaces/data.store.token.interface";
import ClientDTO from "dto/client.dto";

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
      next(error);
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
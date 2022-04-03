import { NextFunction, Request, Response } from "express";
import RequestUser from "interfaces/request.interface.user";
import Controller from "./controller";
import jwt from "jsonwebtoken";
import DataStoreToken from "interfaces/data.store.token.interface";
import UserDTO from "dto/user.dto";

export default class AuthController extends Controller{

  public async register(request: Request, response: Response, next: NextFunction){
    const userData: UserDTO = request.body;
    try {
      const {
        cookie,
        user
      } = await this.authService.register(userData);
      response.setHeader('Set-Cookie', [cookie]);
      response.send(user);
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
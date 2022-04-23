import { RequestHandler, Response } from "express";
import jwt from 'jsonwebtoken';
import validateEnv from "../utils/validateEnv";
import HttpException from "../exceptions/http.exceptions";
import DataStoreToken from "../interfaces/data.store.token.interface";
import Auth from "../interfaces/auth.interface";
import RequestWithToken from "interfaces/request.token.interface";
export default class AuthMiddleware implements Auth{
    constructor(){
    }
  public refreshToken(): RequestHandler{
    return async(request: RequestWithToken, response: Response, next) =>{
      let message: string;
      try {
        const refreshToken: string = request.body.refreshToken;
        if (refreshToken) {
          const secret = validateEnv.JWT_REFRESH_SECRET;
          const verificationResponse = jwt.verify(refreshToken,secret) as DataStoreToken;
          request.dataStoreToken = verificationResponse;
          next();
          return;
        }
      } catch (error) {
        message = error.message;
      }
      if (message) {
        request.error = message;
      }else{
        request.error = "Token Not Found!"
      }
      next();
    }
  }
  public verifyByParam(): RequestHandler {
    return async(request: RequestWithToken,response,next) => {
      let message: string;
      try {
        const token: string = request.params['token'];
        if (token) {
          const secret = validateEnv.JWT_SECRET;
          request.dataStoreToken = jwt.verify(token,secret) as DataStoreToken;
          next();
          return;
        }
      } catch (error) {
        message = error.message;
      }
      if (message) {
        request.error = message;
      }else{
        request.error = "Token Not Found!"
      }
      next();
    }
  }
  public verifyByBody(): RequestHandler {
    return async(request: RequestWithToken,response,next) => {
      let message: string;
        try {
          const token = request.body.token;
          if (token) {
            const secret = validateEnv.JWT_SECRET;
            request.dataStoreToken = jwt.verify(token,secret) as DataStoreToken;
            next();
            return;
          }
        } catch (error) {
          message = error.message;
        }
        if (message) {
          request.error = message;
        }else{
          request.error = "Token Not Found!"
        }
        next();
    }
  }
  
}
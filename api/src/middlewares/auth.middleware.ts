import { RequestHandler, Response } from "express";
import jwt from 'jsonwebtoken';
import validateEnv from "../utils/validateEnv";
import HttpException from "../exceptions/http.exceptions";
import DataStoreToken from "../interfaces/data.store.token.interface";
import Auth from "../interfaces/auth.interface";
import RequesWithToken from "interfaces/request.token.interface";
export default class AuthMiddleware implements Auth{
    constructor(){
    }
  public refreshToken(): RequestHandler{
    return async(request: RequesWithToken, response: Response, next) =>{
      const refreshToken: string = request.body.refreshToken;
      if (refreshToken) {
        const secret = validateEnv.JWT_REFRESH_SECRET;
        try {
          const verificationResponse = jwt.verify(refreshToken,secret) as DataStoreToken;
          request.dataStoreToken = verificationResponse;
          next();
        } catch (error) {
          response.status(400).send(new HttpException(400,error.message).data);
        }
      }else{
        response.status(400).send(new HttpException(400,"Not Found!").data);
      }
    }
  }
  public verifyByParam(): RequestHandler {
    return async(request: RequesWithToken,response,next) => {
      try {
          const token: string = request.params['token'];
          if (token) {
          const secret = validateEnv.JWT_SECRET;
              request.dataStoreToken = jwt.verify(token,secret) as DataStoreToken;
              next();
        } else {
            response.status(400).send(new HttpException(400,"Not Found!").data);
        }
      } catch (error) {
        next(error);
    }
    }
  }
  public verifyByheader(): RequestHandler {
      return async(request: RequesWithToken,response,next) => {
          const bearerHeader = request.headers['authorization'];
          if (bearerHeader) {
              const token = bearerHeader.split(' ')[1];
              const secret = validateEnv.JWT_SECRET;
              try {
                request.dataStoreToken = jwt.verify(token,secret) as DataStoreToken;
              } catch (error) {
                  response.status(400).send(new HttpException(400,error.message).data);
              }
            } else {
                response.status(400).send(new HttpException(400,"Not Found!").data);
            }
            }
  }
  public verifyByBody(): RequestHandler {
    return async(request: RequesWithToken,response,next) => {
      const token = request.body.token;
      if (token) {
          const secret = validateEnv.JWT_SECRET;
          try {
            request.dataStoreToken = jwt.verify(token,secret) as DataStoreToken;
            next();
          } catch (error) {
            next(error);
          }
        } else {
            response.status(400).send(new HttpException(400,"Not Found!").data);
        }
    }
  }
  
}
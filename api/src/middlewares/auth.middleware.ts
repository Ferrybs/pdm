import { RequestHandler, Response } from "express";
import jwt from 'jsonwebtoken';
import validateEnv from "../utils/validateEnv";
import DataStoreToken from "../interfaces/data.store.token.interface";
import Auth from "../interfaces/auth.interface";
import RequestWithToken from "interfaces/request.token.interface";
export default class AuthMiddleware implements Auth{
  verifyPasswordReset(): RequestHandler {
    return async(request: RequestWithToken, response: Response, next) =>{
      let message: string;
      var refreshToken: string;
      try {
        const header = request.header("Authorization");
        refreshToken = header == null ? refreshToken : header.replace("Bearer ", "");
        refreshToken = request.body.refreshToken == null ? refreshToken : request.body.refreshToken;
        refreshToken = request.params['refresh-token'] == null ? refreshToken : request.params['refresh-token'];
        if (refreshToken) {
          const secret = validateEnv.JWT_SECRET;
          const dataStoredInToken = jwt.verify(refreshToken,secret) as DataStoreToken;
          if(dataStoredInToken.typeId == "2"){
            request.dataStoreToken = dataStoredInToken;
            next();
            return;
          }else{
            request.error = "Invalid Type of Token!"
          }
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
  public verifyRefreshToken(): RequestHandler{
    return async(request: RequestWithToken, response: Response, next) =>{
      let message: string;
      var refreshToken: string;
      try {
        const header = request.header("Authorization");
        refreshToken = header == null ? refreshToken : header.replace("Bearer ", "");
        refreshToken = request.body.refreshToken == null ? refreshToken : request.body.refreshToken;
        refreshToken = request.params['refresh-token'] == null ? refreshToken : request.params['refresh-token'];
        if (refreshToken) {
          const secret = validateEnv.JWT_SECRET;
          const dataStoredInToken = jwt.verify(refreshToken,secret) as DataStoreToken;
          if(dataStoredInToken.typeId == "3"){
            request.dataStoreToken = dataStoredInToken;
            next();
            return;
          }else{
            request.error = "Invalid Type of Token!"
          }
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
  public verifyAccesToken(): RequestHandler {
    return async(request: RequestWithToken,response,next) => {
      let message: string;
      var token: string;
        try {
          const header = request.header("Authorization");
          token = header == null ? token : header.replace("Bearer ", "");
          token = request.body.token == null ? token : request.body.token;
          token = request.params['token'] == null ? token : request.params['token'];
          if (token) {
            const secret = validateEnv.JWT_SECRET;
            const dataStoredInToken = jwt.verify(token,secret) as DataStoreToken;
            if (dataStoredInToken.typeId == "1") {
              request.dataStoreToken = dataStoredInToken;
              next();
              return;
            }else{
              request.error = "Invalid Type of Token!"
            }
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
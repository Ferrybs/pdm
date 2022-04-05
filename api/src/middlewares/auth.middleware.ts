import { RequestHandler } from "express";
import RequesWithClient from "../interfaces/request.client.interface";
import jwt from 'jsonwebtoken';
import DataStoredInToken from "../interfaces/data.stored.interface";
import validateEnv from "../utils/validateEnv";
import ClientService from "../services/client.service";
import HttpException from "../exceptions/http.exceptions";

export default class AuthMiddleware{
    private services: ClientService;
    constructor(clientService: ClientService){
        this.services = clientService;
    }

    public verify(): RequestHandler {
        return async(request: RequesWithClient,response,next) => {
            const cookies = request.cookies;
            if (cookies && cookies.Authorization) {
                const secret = validateEnv.JWT_SECRET;
                try {
                  const verificationResponse = jwt.verify(cookies.Authorization, secret) as DataStoredInToken;
                  const id = verificationResponse._id;
                  const client = await this.services.getClient(id);
                  if (client) {
                    request.client = client;
                    next();
                  } else {
                    response.status(400).send(new HttpException(400,"Not Found!").data);
                  }
                } catch (error) {
                    response.status(400).send(new HttpException(400,"Not Found!").data);
                }
              } else {
                  response.status(400).send(new HttpException(400,"Not Found!").data);
              }
              }
        }
}
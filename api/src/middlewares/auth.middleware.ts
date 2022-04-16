import { RequestHandler } from "express";
import RequesWithClient from "../interfaces/request.client.interface";
import jwt from 'jsonwebtoken';
import validateEnv from "../utils/validateEnv";
import ClientService from "../services/client.service";
import HttpException from "../exceptions/http.exceptions";
import DataStoreToken from "interfaces/data.store.token.interface";

export default class AuthMiddleware{
    private services: ClientService;
    constructor(clientService: ClientService){
        this.services = clientService;
    }

    public verify(): RequestHandler {
        return async(request: RequesWithClient,response,next) => {
            const bearerHeader = request.headers['authorization'];
            if (bearerHeader) {
                const token = bearerHeader.split(' ')[1];
                const secret = validateEnv.JWT_SECRET;
                try {
                  const verificationResponse = jwt.verify(token,secret) as DataStoreToken;
                  const client = await this.services.getClient(verificationResponse.id);
                  if (client) {
                    request.client = client;
                    next();
                  } else {
                    response.status(400).send(new HttpException(400,"Not Found!").data);
                  }
                } catch (error) {
                    response.status(400).send(new HttpException(400,error.message).data);
                }
              } else {
                  response.status(400).send(new HttpException(400,"Not Found!").data);
              }
              }
        }
}
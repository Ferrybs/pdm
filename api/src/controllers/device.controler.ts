import DeviceDTO from "../dto/device.dto";
import HttpException from "../exceptions/http.exceptions";
import { NextFunction, Request, Response } from "express";
import RequestWithToken from "../interfaces/request.token.interface";
import DeviceService from "../services/device.service";
import Controller from "./controller";

export default class DeviceController extends Controller{
    private deviceService: DeviceService = new DeviceService();

    public async addDevice(request: RequestWithToken, response: Response){
      if (request.error) {
            response.status(400).send({ ok: false, message: request.error});
          }else{
            try {
              const deviceDTO: DeviceDTO = request.body;
              const dataStoreToken = request.dataStoreToken;
              const clientDTO = await this.clientService.getClientBySessionId(dataStoreToken.id);
              const result = await this.deviceService.addDevice(deviceDTO,clientDTO);
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
    public async getDevices(request: RequestWithToken, response: Response){
      if (request.error) {
        response.status(400).send({ ok: false, message: request.error});
      }else{
        try {
          const dataStoreToken = request.dataStoreToken;
          const clientDTO = await this.clientService.getClientBySessionId(dataStoreToken.id);
          const devices = this.deviceService.getDevices(clientDTO.id);
          response.status(200).send({ok: true,devices});
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
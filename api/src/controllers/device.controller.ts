import DeviceDTO from "../dto/device.dto";
import HttpException from "../exceptions/http.exceptions";
import { Response } from "express";
import RequestWithToken from "../interfaces/request.token.interface";
import Controller from "./controller";
import MeasureDTO from "../dto/measure.dto";
import NotFoundHttpException from "../exceptions/not.found.http.exception";
import HttpData from "interfaces/http.data.interface";

export default class DeviceController extends Controller{

    public async addDevice(request: RequestWithToken, response: Response){
      if (request.error) {
            const httpData: HttpData = { ok: false, message: request.error};
            response.status(400).send(httpData);
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
                const httpData: HttpData = { ok: false, message: error.message};
                response.status(500).send(httpData);
              }
            
            }
          }
    }
    public async addMeasure(request: RequestWithToken, response: Response){
      if (request.error) {
            const httpData: HttpData = { ok: false, message: request.error};
            response.status(400).send(httpData);
          }else{
            try {
              var result: boolean;
              const measureDTO: MeasureDTO = request.body;
              const dataStoreToken = request.dataStoreToken;
              if(await this.deviceService.isMatchSessionDevice(dataStoreToken.id,measureDTO.deviceDTO.id)){
                result = await this.deviceService.addMeasure(measureDTO);
                response.status(200).send({ok: result});
              }else{
                throw new NotFoundHttpException("DEVICE");
              }
              
            } catch (error) {
              if(error instanceof(HttpException)){
                response.status(error.status).send(error.data);
              }else{
                const httpData: HttpData = { ok: false, message: error.message};
                response.status(500).send(httpData);
              }
            
            }
          }
    } 
    public async getMeasures(request: RequestWithToken, response: Response){
      if (request.error) {
        const httpData: HttpData = { ok: false, message: request.error};
        response.status(400).send(httpData);
      }else{
        try {
          const dataStoreToken = request.dataStoreToken;
          const deviceId: string = request.params.id;
          if (await this.deviceService.isMatchSessionDevice(dataStoreToken.id,deviceId)) {
            const measureDTO = await this.deviceService.getMeasures(deviceId);
            response.status(200).send({ok: true,measureDTO});
          }else{
            throw new NotFoundHttpException("DEVICE");
          }
        } catch (error) {
          if(error instanceof(HttpException)){
            response.status(error.status).send(error.data);
          }else{
            const httpData: HttpData = { ok: false, message: error.message};
            response.status(500).send(httpData);
          }
        
        }
      }
    }
    public async getDevices(request: RequestWithToken, response: Response){
      if (request.error) {
        const httpData: HttpData = { ok: false, message: request.error};
        response.status(400).send(httpData);
      }else{
        try {
          const dataStoreToken = request.dataStoreToken;
          const clientDTO = await this.clientService.getClientBySessionId(dataStoreToken.id);
          const devices = await this.deviceService.getDevices(clientDTO.id);
          response.status(200).send({ok: true,devices});
        } catch (error) {
          if(error instanceof(HttpException)){
            response.status(error.status).send(error.data);
          }else{
            const httpData: HttpData = { ok: false, message: error.message};
            response.status(500).send(httpData);
          }
        
        }
      }
    }
}
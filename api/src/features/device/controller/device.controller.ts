import DeviceDTO from "../dto/device.dto";
import HttpException from "../../../exceptions/http.exceptions";
import { Response } from "express";
import RequestWithToken from "../interfaces/request.token.interface";
import Controller from "../../../controllers/controller";
import NotFoundHttpException from "../../../exceptions/not.found.http.exception";
import HttpData from "../interfaces/http.data.interface";
import MeasureQueryDTO from "../dto/measure.query.dto";
import DevicePreferencesDTO from "../dto/device.preferences.dto";
import DeviceLocalizationDTO from "../dto/device.localization.dto";
import { identity, result } from "lodash";
import DeviceQueryLocalizationDTO from "../dto/device.query.localization.dto";

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
    public async addPreferences(request: RequestWithToken, response: Response) {
      if (request.error) {
        const httpData: HttpData = { ok: false, message: request.error};
        response.status(400).send(httpData);
      }else{
        try {
          const dataStoreToken = request.dataStoreToken;
          const devicePreferencesDTO: DevicePreferencesDTO = request.body;
          const result = await this.deviceService.addPreferences(devicePreferencesDTO,dataStoreToken);
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
    public async getPreferences(request: RequestWithToken, response: Response){
      if (request.error) {
        const httpData: HttpData = { ok: false, message: request.error};
        response.status(400).send(httpData);
      }else{
        try {
          const dataStoreToken = request.dataStoreToken;
          const deviceId: string = request.params.id;
          const deviceDTO = new DeviceDTO()
          deviceDTO.id = deviceId;
          const devicePreferencesDTO = await this.deviceService.getPreferences(deviceDTO,dataStoreToken);
          if (devicePreferencesDTO) {
            response.status(200).send({ok: true,devicePreferencesDTO});
          }else{
            response.status(200).send({ok: false});
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
    public async getLocalization(request: RequestWithToken, response: Response){
      if (request.error) {
        const httpData: HttpData = { ok: false, message: request.error};
        response.status(400).send(httpData);
      }else{
        try {
          const dataStoreToken = request.dataStoreToken;
          const deviceId= request.params.id;
          const localizationDTO = await this.deviceService.getLocalization(deviceId,dataStoreToken);
          if (localizationDTO) {
            response.status(200).send({ok: true,localizationDTO});
          }else{
            response.status(400).send({ok: false});
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
    public async getMapLocalizations(request: RequestWithToken, response: Response){
      if (request.error) {
        const httpData: HttpData = { ok: false, message: request.error};
        response.status(400).send(httpData);
      }else{
        try {
          const dataStoreToken = request.dataStoreToken;
          const deviceQueryLocDTO: DeviceQueryLocalizationDTO = request.body;
          const deviceMapDTO = await this.deviceService.getMapLocalization(deviceQueryLocDTO,dataStoreToken);
          if (deviceMapDTO) {
            response.status(200).send({ok: true,deviceMapDTO});
          }else{
            response.status(200).send({ok: false});
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
          const measure_query: MeasureQueryDTO = request.body;
          if (await this.deviceService.isMatchSessionDevice(dataStoreToken.id,measure_query.deviceId)) {
            const measureDTO = await this.deviceService.getMeasures(measure_query);
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
          const deviceDTO = await this.deviceService.getDevices(clientDTO.id);
          response.status(200).send({ok: true,deviceDTO});
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
    public async getConfigs(request: RequestWithToken, response: Response) {
      if (request.error) {
        const httpData: HttpData = { ok: false, message: request.error};
        response.status(400).send(httpData);
      }else{
        try {
          const dataStoreToken = request.dataStoreToken;
          await this.clientService.getClientBySessionId(dataStoreToken.id);
          const configsDTO = this.deviceService.getConfigs();
          if (configsDTO) {
            response.status(200).send({ok: true,configsDTO});
          }else{
            response.status(200).send({ok: false});
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
    public async deleteDevice(request: RequestWithToken, response: Response){
      if (request.error) {
        const httpData: HttpData = { ok: false, message: request.error};
        response.status(400).send(httpData);
      }else{
        try {
          var result = false;
          const dataStoreToken = request.dataStoreToken;
          const deviceId = request.params['id'];
          if (this.deviceService.isMatchSessionDevice(dataStoreToken.id,deviceId)) {
            result = await this.deviceService.deleteDevice(deviceId);
          }    
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
}
import { transformAndValidate } from 'class-transformer-validator';
import PersonDTO from '../features/client/dto/person.dto';
import { RequestHandler, Response } from 'express';
import Validation from '../interfaces/validation.interface';
import { ValidationError } from 'class-validator';
import RequestWithError from '../interfaces/request.error.interface';
import DeviceDTO from '../dto/device.dto';
import MeasureDTO from '../dto/measure.dto';
import TypeMeasureDTO from '../dto/type.measure.dto';
import MeasureQueryDTO from '../dto/measure.query.dto';
import SendEmailDTO from '../dto/send.email.dto';
import ResetPasswordDTO from '../dto/reset.password.dto';
import LoginDTO from '../dto/login.dto';
import RegisterDTO from '../dto/register.dto';
import DevicePreferencesDTO from '../dto/device.preferences.dto';
import DeviceLocalizationDTO from '../dto/device.localization.dto';
import ChatbotMessageDTO from '../features/chatbot/dto/chatbot.message.request.dto';

export default class ValidationMiddleware implements Validation {

  public localization():RequestHandler {
    return async (request: RequestWithError, response: Response, next) =>{
      let message: string;
      try {
        const localization: DeviceLocalizationDTO = request.body;
        await transformAndValidate(DeviceDTO,localization.deviceDTO);
        await transformAndValidate(DeviceLocalizationDTO,localization);
      } catch (err) {
        message = err.map((err: ValidationError) => Object.values(err.constraints)).join(', ');
      }
      if(message){
        request.error = message;
      }
      next();
    }
  }
  public preferences():RequestHandler {
    return async (request: RequestWithError, response: Response, next) =>{
      let message: string;
      try {
        const devicePreferencesDTO: DevicePreferencesDTO = request.body;
        await transformAndValidate(DeviceDTO,devicePreferencesDTO.deviceDTO);
        await transformAndValidate(DevicePreferencesDTO,devicePreferencesDTO);
      } catch (err) {
        message = err.map((err: ValidationError) => Object.values(err.constraints)).join(', ');
      }
      if(message){
        request.error = message;
      }
      next();
    }
  }
  public measureQuery(): RequestHandler {
    return async (request: RequestWithError, response: Response, next) =>{
      let message: string;
      try {
        const measure_query: MeasureQueryDTO = request.body;
        await transformAndValidate(MeasureQueryDTO,measure_query);
      } catch (err) {
        message = err.map((err: ValidationError) => Object.values(err.constraints)).join(', ');
      }
      if(message){
        request.error = message;
      }
      next();
    }
  }


  public device(): RequestHandler {
    return async (request: RequestWithError, response: Response, next) =>{
      let message: string;
      try {
        const deviceDTO: DeviceDTO = request.body;
        await transformAndValidate(DeviceDTO,deviceDTO);
      } catch (err) {
        message = err.map((err: ValidationError) => Object.values(err.constraints)).join(', ');
      }
      if(message){
        request.error = message;
      }
      next();
    }
  }
  public measure(): RequestHandler {
    return async (request: RequestWithError, response: Response, next) =>{
      let message: string;
      try {
        const measureDTO: MeasureDTO = request.body;
        await transformAndValidate(MeasureDTO,measureDTO);
        await transformAndValidate(DeviceDTO,measureDTO.deviceDTO);
        await transformAndValidate(TypeMeasureDTO,measureDTO.typeDTO);
      } catch (err) {
        message = err.map((err: ValidationError) => Object.values(err.constraints)).join(', ');
      }
      if(message){
        request.error = message;
      }
      next();
    }
  }
  public email(): RequestHandler {
    return async (request: RequestWithError, response: Response, next) =>{
      let message: string;
      try {
        const email = request.body;
        await transformAndValidate(SendEmailDTO,email);
      } catch (err) {
        message = err.map((err: ValidationError) => Object.values(err.constraints)).join(', ');
      }
      if(message){
        request.error = message;
      }
      next();

    }
  }
  public password(): RequestHandler{
    return async (request: RequestWithError, response: Response, next) =>{
      let message: string;
      try {
        const password = request.body;
        await transformAndValidate(ResetPasswordDTO,password);
      } catch (err) {
        message = err.map((err: ValidationError) => Object.values(err.constraints)).join(', ');
      }
      if(message){
        request.error = message;
      }
      next();
    }
  }
  public register(): RequestHandler{
    return async (request: RequestWithError, response: Response, next) => {
        let message: string;
      try {
          const aux: RegisterDTO = request.body;
          const loginDTO = aux.loginDTO;
          const personDTO = aux.personDTO;
          await transformAndValidate(LoginDTO,loginDTO);
          await transformAndValidate(PersonDTO,personDTO);
        } catch (err) {
          if(Array.isArray(err)){
            message = err.map((err: ValidationError) => Object.values(err.constraints)).join(', ');
          }else{
            message = err.message;
          }
        }
        if(message){
          request.error = message;
        }
        next();
  
    };
  }
  public login(): RequestHandler {
    return async (request: RequestWithError, response: Response, next)  => {
        let message: string
      try {
          const aux = request.body;
          const loginDTO = new LoginDTO();
          loginDTO.email = aux.email;
          loginDTO.password = aux.password;
          await transformAndValidate(LoginDTO, loginDTO);
        } catch (err) {
          message = err.map((err: ValidationError) => Object.values(err.constraints)).join(', ');
        }
        if(message){
          request.error = message;
        }
        next();
  
    };
  }
}
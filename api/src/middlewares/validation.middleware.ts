import { transformAndValidate } from 'class-transformer-validator';
import PersonDTO from '../dto/person.dto';
import { RequestHandler, Response } from 'express';
import Validation from '../interfaces/validation.interface';
import { ValidationError } from 'class-validator';
import RequestWithError from '../interfaces/request.error.interface';
import DeviceDTO from '../features/device/dto/device.dto';
import MeasureDTO from '../features/device/dto/measure.dto';
import TypeMeasureDTO from '../features/device/dto/type.measure.dto';
import MeasureQueryDTO from '../features/device/dto/measure.query.dto';
import SendEmailDTO from '../dto/send.email.dto';
import ResetPasswordDTO from '../dto/reset.password.dto';
import LoginDTO from '../dto/login.dto';
import RegisterDTO from '../dto/register.dto';
import DevicePreferencesDTO from '../features/device/dto/device.preferences.dto';
import DeviceLocalizationDTO from '../dto/device.localization.dto';
import ChatbotMessageDTO from '../features/chatbot/dto/chatbot.message.request.dto';

export default class ValidationMiddleware implements Validation {

  
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
import { transformAndValidate } from 'class-transformer-validator';
import ClientDTO from '../dto/client.dto';
import CredentialsDTO from '../dto/credentials.dto';
import PersonDTO from '../dto/person.dto';
import { RequestHandler, Response } from 'express';
import Validation from '../interfaces/validation.interface';
import { ValidationError } from 'class-validator';
import RequestWithError from '../interfaces/request.error.interface';
import DeviceDTO from '../dto/device.dto';
import MeasureDTO from '../dto/measure.dto';
import TypeMeasureDTO from '../dto/type.measure.dto';
export default class ValidationMiddleware implements Validation {


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
        const email = request.body.email;
        const credentialsDTO = new CredentialsDTO()
        credentialsDTO.password = "1234567aA";
        credentialsDTO.email = email;
        await transformAndValidate(CredentialsDTO,credentialsDTO);
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
        const password = request.body.pass;
        const credentialsDTO = new CredentialsDTO()
        credentialsDTO.password = password;
        credentialsDTO.email = "email@email.com";
        await transformAndValidate(CredentialsDTO,credentialsDTO);
      } catch (err) {
        message = err.map((err: ValidationError) => Object.values(err.constraints)).join(', ');
      }
      if(message){
        request.error = message;
      }
      next();
    }
  }
  public client(): RequestHandler{
    return async (request: RequestWithError, response: Response, next) => {
        let message: string;
      try {
          const aux: ClientDTO = request.body;
          const credentialsDTO = aux.credentialsDTO;
          const personDTO = aux.personDTO;
          await transformAndValidate(CredentialsDTO,credentialsDTO);
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
  public credentials(): RequestHandler {
    return async (request: RequestWithError, response: Response, next)  => {
        let message: string
      try {
          const aux = request.body as CredentialsDTO;
          const credentialsDTO = new CredentialsDTO();
          credentialsDTO.email = aux.email;
          credentialsDTO.password = aux.password;
          await transformAndValidate(CredentialsDTO, credentialsDTO);
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
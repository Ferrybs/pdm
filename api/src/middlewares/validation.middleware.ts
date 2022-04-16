import { transformAndValidate } from 'class-transformer-validator';
import ClientDTO from '../dto/client.dto';
import CredentialsDTO from '../dto/credentials.dto';
import PersonDTO from '../dto/person.dto';
import { RequestHandler } from 'express';
import HttpException from '../exceptions/http.exceptions';
import Validation from 'interfaces/validation.interface';

export default class ValidationMiddleware implements Validation {

  public client(): RequestHandler{
    return async (req, res, next) => {
        let message: string
      try {
          const aux = req.body as ClientDTO;
          const credentialsDTO = aux.credentialsDTO;
          const personDTO = aux.personDTO;
          await transformAndValidate(CredentialsDTO, credentialsDTO);
          await transformAndValidate(PersonDTO, personDTO);
        } catch (err) {
          message = err.map((err) => Object.values(err.constraints)).join(', ');
        }
        if(message){
          res.status(400).send(new HttpException(400,message).data);
        }else{
            next();
        }
  
    };
  }
  public credentials(): RequestHandler {
    return async (req, res, next) => {
        let message: string
      try {
          const aux = req.body as CredentialsDTO;
          const credentialsDTO = new CredentialsDTO();
          credentialsDTO.email = aux.email;
          credentialsDTO.password = aux.password;
          await transformAndValidate(CredentialsDTO, credentialsDTO);
        } catch (err) {
          message = err.map((err) => Object.values(err.constraints)).join(', ');
        }
        if(message){
          res.status(400).send(new HttpException(400,message).data);
        }else{
            next();
        }
  
    };
  }
}
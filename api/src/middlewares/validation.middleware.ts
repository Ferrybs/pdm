import { transformAndValidate } from 'class-transformer-validator';
import ClientDTO from '../dto/client.dto';
import CredentialsDTO from '../dto/credentials.dto';
import PersonDTO from '../dto/person.dto';
import { RequestHandler } from 'express';
import HttpException from '../exceptions/http.exceptions';

function validationMiddleware<T>(type: any): RequestHandler {
  return async (req, res, next) => {
      let message: string
    try {
        const aux = req.body as ClientDTO;
        const credentialsDTO = aux.credentialsDTO;
        const personDTO = aux.personDTO;
        const credDto = await transformAndValidate(CredentialsDTO, credentialsDTO);
        console.log(credDto);
        const perDTO = await transformAndValidate(PersonDTO, personDTO);
        console.log(perDTO);
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

export default validationMiddleware;
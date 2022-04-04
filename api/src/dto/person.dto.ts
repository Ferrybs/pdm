import { MinLength } from "class-validator";

export default class PersonDTO {
    @MinLength(3, {
        message: 'Name need to have at least 3 letters',
      })    
    public name: string;

    @MinLength(3, {
        message: 'Last Name need to have at least 3 letters',
      })  
    public lastName: string;
}
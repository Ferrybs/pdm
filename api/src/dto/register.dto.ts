import { ValidateNested } from 'class-validator';
import LoginDTO from './login.dto';
import PersonDTO from "./person.dto"
export default class RegisterDTO {
    @ValidateNested()  
    public personDTO?: PersonDTO;

    @ValidateNested()
    public loginDTO?: LoginDTO;
}
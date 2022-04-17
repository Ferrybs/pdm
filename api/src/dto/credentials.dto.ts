import { IsEmail, Matches, MinLength } from "class-validator";
export default class CredentialsDTO {
    @IsEmail()
    public email: string;

    @Matches(new RegExp("(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"), {
        message: `Password must contain 8 or more characters that 
        are of at least one number, and one uppercase and lowercase letter`,
      })
    
    public password?: string;
}
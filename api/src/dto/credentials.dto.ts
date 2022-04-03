import { IsEmail, MinLength } from "class-validator";

export default class CredentialsDTO {
    @IsEmail()
    public email: string;

    @MinLength(6, {
        message: 'Password is shorter than 6 letters',
      })
    public password: string;
}
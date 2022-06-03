import { IsEmail } from "class-validator";
export default class CredentialsDTO {
    @IsEmail()
    public email?: string;
}
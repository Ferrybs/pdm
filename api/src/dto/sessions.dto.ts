import ClientDTO from './client.dto';


export default class SessionsDTO {

    public id?: string;
    public description?: string;
    public iat?: number;
    public expiresIn?: number;
}
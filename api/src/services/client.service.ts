import ClientDTO from "../dto/client.dto";
import CredentialsDTO from "../dto/credentials.dto";
import bcrypt from "bcrypt";
import HttpException from "../exceptions/http.exceptions";
import Services from "./services";

export default class ClientService extends Services{
    //login
    //signup
    //verify if email exists
    //
    // getUser()
    //toDTO
    //toEntity
    public async getClientById(id: string){
        try {
            const result = await this.database.findClientById(id);
            const clientDTO = new ClientDTO();
            clientDTO.id = result.id;
            clientDTO.personDTO = result.person;
            clientDTO.credentialsDTO = result.credentials;
            return clientDTO;
        } catch (error) {
            throw (new HttpException(400,error.message));
        }
    }
    public async updateCredentials(credentialsDTO: CredentialsDTO): Promise<boolean> {
        try {
            const hashedPassword =  await bcrypt.hash(credentialsDTO.password,10);
            credentialsDTO.password = hashedPassword;
            const result = await this.database.updateCredentials(credentialsDTO);
            return result;
        } catch (error) {
            
        }
    }
}
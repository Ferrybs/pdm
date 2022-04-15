import ClientDTO from "../dto/client.dto";
import CredentialsDTO from "../dto/credentials.dto";
import PersonDTO from "../dto/person.dto";
import HttpException from "../exceptions/http.exceptions";
import Client from "../entity/client.entity";
import Services from "./services";

export default class ClientService extends Services{
    //login
    //signup
    //verify if email exists
    //
    // getUser()
    //toDTO
    //toEntity
    public async getClient(id: string){
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
}
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
        const  appDataSource =  this.getAppDataSource();
        try {
            await appDataSource.initialize();
            const client = await appDataSource.manager.findOne(
                Client,{where:{id: id}, relations: ['credentials', 'person']});
            await appDataSource.destroy();
            const result =  new ClientDTO();
            result.id = client.id
            result.credentialsDTO = client.credentials as CredentialsDTO;
            result.personDTO = client.person as PersonDTO;
            result.credentialsDTO.password = null;
            return result
        } catch (error) {
            await appDataSource.destroy();
            throw (new HttpException(400,error.message));

        }
    }
}
import User from "../entity/client.entity";
import Services from "./services";

export default class UserService extends Services{
    //login
    //signup
    //verify if email exists
    //
    // getUser()
    //toDTO
    //toEntity
    async getUser(id: string){
        try {
            const database = this.getAppDataSource();
            const userRepository = database.getRepository(User);
            const user_response =  await userRepository.findOneBy({id: id});
            return user_response;
        } catch (error) {
            
        }
    }
}
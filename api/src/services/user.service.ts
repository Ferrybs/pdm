import User from "../entity/user.entity";
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
            const database = this.getDatabase();
            const userRepository = database.getRepository(User);
            const user_response =  await userRepository.findOneBy({idUser: id});
            return user_response;
        } catch (error) {
            
        }
    }
}
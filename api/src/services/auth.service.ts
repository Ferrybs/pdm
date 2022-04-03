import UserDTO from "../dto/user.dto";
import Credentials from "../entity/credentials.entity";
import User from "../entity/user.entity";
import Services from "./services";
import bcrypt from "bcrypt"
import DataStoreToken from "../interfaces/data.store.token.interface";
import TokenData from "../interfaces/token.data.interface";
import jwt from "jsonwebtoken";
import validateEnv from "../utils/validateEnv";

export default class AuthService extends Services{
    private userRepository = this.getDatabase().getRepository(User);
    private credentialsRepository = this.getDatabase().getRepository(Credentials);

    public async register(userData: UserDTO){
        if(
            await this.credentialsRepository.findOneBy({email: userData.credentialsDTO.email})
        ){
            throw Error("Erro!");
        }
        const hashedPassword = await bcrypt.hash(userData.credentialsDTO.password, 10);
        userData.credentialsDTO.password = hashedPassword;
        const user = this.createUser(userData);
        await this.userRepository.save(user);
        user.credentials.password = null;
        const tokenData = this.createToken(user);
        const cookie = this.createCookie(tokenData);
        return {
            cookie,
            user
        }

    }
    public createCookie(tokenData: TokenData) {
        return `Authorization=${tokenData.token}; HttpOnly; Max-Age=${tokenData.expiresIn}`;
      }
    public createToken(user: User): TokenData {
        const expiresIn = 60 * 60; // an hour
        const secret = validateEnv.JWT_SECRET;
        const dataStoredInToken: DataStoreToken = {
          id: user.idUser,
        };
        return {
          expiresIn,
          token: jwt.sign(dataStoredInToken, secret, { expiresIn }),
        };
      }
}
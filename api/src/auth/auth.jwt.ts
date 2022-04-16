import Client from "../entity/client.entity";
import DataStoreToken from "../interfaces/data.store.token.interface";
import TokenData from "../interfaces/token.data.interface";
import validateEnv from "../utils/validateEnv";
import jwt from "jsonwebtoken";

export default class AuthJwt{

    public createToken(client: Client): TokenData {
        const expiresIn = 60*60; // an hour
        const secret = validateEnv.JWT_SECRET;
        const dataStoredInToken: DataStoreToken = {
          id: client.id,
        };
        return {
          expiresIn,
          token: jwt.sign(dataStoredInToken, secret, { expiresIn }),
          refreshToken: this.createRefreshToken(client)
        };
      }
    
    private createRefreshToken(client: Client): string {
        const expiresIn = 60*60*24*30; // an month
        const secret = validateEnv.JWT_REFRESH_SECRET;
        const dataStoredInToken: DataStoreToken = {
          id: client.id,
        };
        return jwt.sign(dataStoredInToken, secret, { expiresIn });
      }
    
    
}
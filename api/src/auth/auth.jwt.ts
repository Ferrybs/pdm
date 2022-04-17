import Client from "../entity/client.entity";
import DataStoreToken from "../interfaces/data.store.token.interface";
import TokenData from "../interfaces/token.data.interface";
import validateEnv from "../utils/validateEnv";
import jwt from "jsonwebtoken";
import ClientDTO from "dto/client.dto";
import StoreAllToken from "interfaces/store.all.token.interface";

export default class AuthJwt{
    private _secret: string = validateEnv.JWT_SECRET;
    private _secretRefresh: string =validateEnv.JWT_REFRESH_SECRET;
    private _expiresInRefresh: number = 60*60*24*30;
    private _expiresIn: number = 60*60;

    public createToken(clientDTO: ClientDTO): StoreAllToken {
        const dataStoredInToken: DataStoreToken = {
          id: clientDTO.id,
        };
        return {
          accessToken: {
            token: jwt.sign(dataStoredInToken, this._secret, {expiresIn:this._expiresIn} ),
            expiresIn: this._expiresIn},
          refreshToken: this.createRefreshToken(clientDTO)
        };
      }
    
    private createRefreshToken(clientDTO: ClientDTO): TokenData {
        const dataStoredInToken: DataStoreToken = {
          id: clientDTO.id,
        };
        return {
          token: jwt.sign(dataStoredInToken, this._secretRefresh, {expiresIn:this._expiresInRefresh} ),
          expiresIn: this._expiresInRefresh
        };
      }
    
    
}
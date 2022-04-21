import DataStoreToken from "../interfaces/data.store.token.interface";
import TokenData from "../interfaces/token.data.interface";
import validateEnv from "../utils/validateEnv";
import jwt from "jsonwebtoken";

export default class AuthJwt{
    private _secret: string = validateEnv.JWT_SECRET;
    private _secretRefresh: string =validateEnv.JWT_REFRESH_SECRET;
    private _expiresInRefresh: number = 60*60*24*30;
    private _expiresInAccess: number = 60*60;

    public createAccessToken(sessionId: string): TokenData {
      const iat: number = Math.floor(Date.now() / 1000);
        const dataStoredInToken: DataStoreToken = {
          id: sessionId,
          iat: iat,
          expiresIn: this._expiresInAccess + iat
        };
        return {
            token: jwt.sign(dataStoredInToken, this._secret, {expiresIn:this._expiresInAccess} ),
            expiresIn: this._expiresInAccess + iat,
            iat: iat
          };
    
      }
    
    public createRefreshToken(id: string): TokenData {
      const iat: number = Math.floor(Date.now() / 1000);
        const dataStoredInToken: DataStoreToken = {
          id: id,
          iat: iat,
          expiresIn: iat + this._expiresInRefresh
        };
        return {
          token: jwt.sign(dataStoredInToken, this._secretRefresh, {expiresIn:this._expiresInRefresh} ),
          expiresIn: this._expiresInRefresh + iat,
          iat: iat
        };
      }
    
    
}
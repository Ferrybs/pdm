import TokenData from "./token.data.interface";

export default interface StoreAllToken {
    token: TokenData;
    refreshToken: TokenData;
}
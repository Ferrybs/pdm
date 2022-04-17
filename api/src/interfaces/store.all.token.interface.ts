import TokenData from "./token.data.interface";

export default interface StoreAllToken {
    accessToken: TokenData;
    refreshToken: TokenData;
}
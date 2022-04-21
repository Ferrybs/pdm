import { Request } from "express";
import DataStoreToken from "./data.store.token.interface";

export default interface RequesWithToken extends Request{
    dataStoreToken: DataStoreToken
}
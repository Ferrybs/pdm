import { Request } from "express";
import DataStoreToken from "./data.store.token.interface";

export default interface RequestWithError extends Request{
    error: string;
}
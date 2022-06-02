import { RequestHandler } from "express";

export default interface Auth{
    verifyAccesToken(): RequestHandler;
    verifyPasswordReset(): RequestHandler;
    verifyRefreshToken(): RequestHandler;
}
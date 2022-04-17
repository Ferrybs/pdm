import { RequestHandler } from "express";

export default interface Auth{
    verifyByheader(): RequestHandler
    verifyByParam(): RequestHandler
    refreshToken(): RequestHandler
}
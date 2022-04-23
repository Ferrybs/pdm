import { RequestHandler } from "express";

export default interface Auth{
    verifyByParam(): RequestHandler
    verifyByBody(): RequestHandler
    refreshToken(): RequestHandler
}
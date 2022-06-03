import { RequestHandler } from "express";

export default interface Validation{
    register(): RequestHandler
    login(): RequestHandler
    email(): RequestHandler
    password(): RequestHandler
}
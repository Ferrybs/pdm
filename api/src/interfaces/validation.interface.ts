import { RequestHandler } from "express";

export default interface Validation{
    client(): RequestHandler
    credentials(): RequestHandler
}
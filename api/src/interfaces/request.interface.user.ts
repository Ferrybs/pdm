import UserDTO from "dto/user.dto";
import { Request } from "express";

export default interface RequestUser extends Request{
    user: UserDTO
}
import { cleanEnv, port, str } from "envalid";
import dotenv from "dotenv";

dotenv.config();

const validateEnv = cleanEnv(process.env, {
    PORT:port(),
    DATABASE_HOST: str(),
    DATABASE: str(),
    DATABASE_USER: str(),
    DATABASE_PORT: port(),
    DATABASE_PASS: str(),
    JWT_SECRET: str()
  })

export default validateEnv;
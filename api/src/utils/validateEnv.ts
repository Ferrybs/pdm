import { cleanEnv, port, str } from "envalid";
import dotenv from "dotenv";

dotenv.config();

const validateEnv = cleanEnv(process.env, {
    PORT:port(),
    DATABASE_URL: str(),
    JWT_SECRET: str(),
    EMAIL_HOST: str(),
    EMAIL_PORT: port(),
    EMAIL_USER: str(),
    EMAIL_PASS: str()
  })

export default validateEnv;
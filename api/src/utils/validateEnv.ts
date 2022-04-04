import { cleanEnv, port, str } from "envalid";
import dotenv from "dotenv";

dotenv.config();

const validateEnv = cleanEnv(process.env, {
    PORT:port(),
    DATABASE_URI: str(),
    JWT_SECRET: str()
  })

export default validateEnv;
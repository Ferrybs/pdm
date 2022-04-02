import { cleanEnv, port, str } from "envalid";
import dotenv from "dotenv";

dotenv.config();

const validateEnv = cleanEnv(process.env, {
    PORT:port()
  })

export default validateEnv;
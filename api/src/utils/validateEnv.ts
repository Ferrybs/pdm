import { cleanEnv, email, host, port, str } from "envalid";
import dotenv from "dotenv";

dotenv.config();

const validateEnv = cleanEnv(process.env, {
    PORT:port(),
    DATABASE_URL: str(),
    JWT_SECRET: str(),
    EMAIL_HOST: str(),
    EMAIL_PORT: port(),
    EMAIL_USER: email(),
    EMAIL_PASS: str(),
    MQTT_HOST: host(),
    MQTT_PORT: port(),
    MQTT_USER: str(),
    MQTT_PASS: str()
  })

export default validateEnv;
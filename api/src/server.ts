import App from "./app";
import validateEnv from "./utils/validateEnv";

const app = new App(validateEnv.PORT);
app.listen();
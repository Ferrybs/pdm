import HomeController from "./controllers/home.controller";
import App from "./app";
import validateEnv from "./utils/validateEnv";

const app = new App(
    validateEnv.PORT,
    [
        new HomeController()
    ]
    );
app.listen();
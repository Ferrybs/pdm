import App from "./app";
import validateEnv from "./utils/validateEnv";
import HomeRoutes from "./routes/home.routes";
import AuthRoutes from "./routes/auth.routes";

const app = new App(
    validateEnv.PORT,
    [
        new HomeRoutes(),
        new AuthRoutes()
    ]
    );
    
app.listen();
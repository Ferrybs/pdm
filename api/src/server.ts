import App from "./app";
import validateEnv from "./utils/validateEnv";
import HomeRoutes from "./routes/home.routes";
import AuthRoutes from "./routes/auth.routes";
import 'reflect-metadata';
import 'es6-shim';




const app = new App(
    validateEnv.PORT,
    [
        new HomeRoutes(),
        new AuthRoutes()
    ]
    );
    
app.listen();
import App from "./app";
import validateEnv from "./utils/validateEnv";
import HomeRoutes from "./routes/home.routes";
import AuthRoutes from "./routes/auth.routes";
import 'reflect-metadata';
import 'es6-shim';
import DeviceRoutes from "./routes/device.routes";
import ClientRoutes from "./routes/client.routes";
import ChatbotRoutes from "./chatbot/chatbot.routes";

const app = new App(
    validateEnv.PORT,
    [
        new HomeRoutes(),
        new AuthRoutes(),
        new ClientRoutes(),
        new DeviceRoutes(),
        new ChatbotRoutes()
    ]
    );
    
app.listen();


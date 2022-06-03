import App from "./app";
import validateEnv from "./utils/validateEnv";
import HomeRoutes from "./features/home/routes/home.routes";
import AuthRoutes from "./features/auth/routes/auth.routes";
import 'reflect-metadata';
import 'es6-shim';
import DeviceRoutes from "./features/device/routes/device.routes";
import ChatbotRoutes from "./features/chatbot/routes/chatbot.routes";
import { DataSource } from "typeorm";
import PostgresDataSource from "configs/data.source.postgres";
import ClientRoutes from "features/client/routes/client.routes";


const _appDataSource: DataSource = new PostgresDataSource()._appDataSource;

const app = new App(
    validateEnv.PORT,
    [
        new HomeRoutes(_appDataSource),
        new AuthRoutes(_appDataSource),
        new ClientRoutes(_appDataSource),
        new DeviceRoutes(_appDataSource),
        new ChatbotRoutes(_appDataSource)
    ]
    );
    
app.listen();


import App from "./app";
import validateEnv from "./utils/validateEnv";
import HomeRoutes from "./routes/home.routes";
import AuthRoutes from "./routes/auth.routes";
import 'reflect-metadata';
import 'es6-shim';
import DeviceRoutes from "./routes/device.routes";
import ChatbotRoutes from "./features/chatbot/routes/chatbot.routes";
import Database from "./interfaces/database.interface";
import PostgresDatabase from "./database/postgres.database";
import { DataSource } from "typeorm";
import PostgresDataSource from "configs/data.source.postgres";
import ClientRoutes from "features/client/routes/client.routes";

// const database: Database = new PostgresDatabase();
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


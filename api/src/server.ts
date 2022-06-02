import App from "./app";
import validateEnv from "./utils/validateEnv";
import HomeRoutes from "./routes/home.routes";
import AuthRoutes from "./routes/auth.routes";
import 'reflect-metadata';
import 'es6-shim';
import DeviceRoutes from "./routes/device.routes";
import ClientRoutes from "./routes/client.routes";
import ChatbotRoutes from "./features/chatbot/routes/chatbot.routes";
import Database from "./interfaces/database.interface";
import PostgresDatabase from "./database/postgres.database";

const database: Database = new PostgresDatabase();

const app = new App(
    validateEnv.PORT,
    [
        new HomeRoutes(database),
        new AuthRoutes(database),
        new ClientRoutes(database),
        new DeviceRoutes(database),
        new ChatbotRoutes(database)
    ]
    );
    
app.listen();


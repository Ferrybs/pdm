import HomeController from "./controllers/home.controller";
import App from "./app";
import validateEnv from "./utils/validateEnv";
import PostgresDataSource from "configs/data.source.postgres";
import User from "entity/user.entity";
import Person from "entity/person.entity";
import { EntitySchemaOptions } from "typeorm";
import Credentials from "./entity/credentials.entity";

const entityOp = new EntitySchemaOptions

const database = new PostgresDataSource(
    [
        new User(entityOp),
        new Person(entityOp),
        new Credentials(entityOp)
    ]
);

const app = new App(
    validateEnv.PORT,
    [
        new HomeController()
    ]
    );
app.listen();
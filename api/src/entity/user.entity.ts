import { Entity, EntitySchema, JoinColumn, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import Credentials from './credentials.entity';
import Person from "./person.entity"

@Entity()
export default class User extends EntitySchema {    
    @PrimaryGeneratedColumn("uuid")
    public idUser: string;

    @OneToOne(() => Person, (person: Person) => person.idPerson)
    @JoinColumn()
    public person: Person;

    @OneToOne(() => Credentials, (credentials: Credentials) => credentials.email)
    @JoinColumn()
    public credentials: Credentials;
}
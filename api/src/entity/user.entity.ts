import { Entity, JoinColumn, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import Credentials from './credentials.entity';
import Person from "./person.entity"

@Entity()
export default class User{    
    @PrimaryGeneratedColumn("uuid")
    public idUser: string;

    @OneToOne(() => Person, (person: Person) => person.idPerson)
    @JoinColumn()
    public person: Person;

    @OneToOne(() => Credentials, (credentials: Credentials) => credentials.email)
    @JoinColumn()
    public credentials: Credentials;
}
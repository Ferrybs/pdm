import { Entity, JoinColumn, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import Credentials from './credentials.entity';
import Person from "./person.entity"

@Entity()
export default class Client{    
    @PrimaryGeneratedColumn("uuid")
    public id?: string;

    @OneToOne(() => Person, (person: Person) => person.client)
    @JoinColumn()
    public person: Person;

    @OneToOne(() => Credentials, (credentials: Credentials) => credentials.client)
    @JoinColumn()
    public credentials: Credentials;
}
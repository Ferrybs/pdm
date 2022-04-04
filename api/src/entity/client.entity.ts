import { Entity, JoinColumn, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import Credentials from './credentials.entity';
import Person from "./person.entity"

@Entity()
export default class Client{    
    @PrimaryGeneratedColumn("uuid")
    public idUser?: string;

    @OneToOne(() => Person)
    @JoinColumn()
    public person: Person;

    @OneToOne(() => Credentials)
    @JoinColumn()
    public credentials: Credentials;
}
import { Entity, JoinColumn, OneToMany, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import Credentials from './credentials.entity';
import Device from "./device.entiy";
import Person from "./person.entity"
import Sessions from "./sessions.entity";

@Entity()
export default class Client{    
    @PrimaryGeneratedColumn("uuid")
    public id?: string;

    @OneToOne(() => Person, (person: Person) => person.client)
    @JoinColumn()
    public person?: Person;

    @OneToOne(() => Credentials, (credentials: Credentials) => credentials.client)
    @JoinColumn()
    public credentials?: Credentials;

    @OneToMany(() => Sessions, sessions => sessions.client, {cascade: true})
    public sessions?: Sessions[];

    @OneToMany(() => Device, device => device.client)
    public devices?: Device[];
}
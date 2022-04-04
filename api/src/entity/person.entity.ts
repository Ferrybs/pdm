import { Column, Entity, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import Client from './client.entity';

@Entity()
export default class Person{    
    @PrimaryGeneratedColumn("uuid")
    public id: string;

    @Column()
    public name: string;

    @Column()
    public lastName: string;

    @OneToOne(() => Client, client => client.id)
    public client: Client;
}
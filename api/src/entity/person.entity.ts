import { Column, Entity, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import User from './user.entity';

@Entity()
export default class Person {    
    @PrimaryGeneratedColumn("uuid")
    public idPerson: string;

    @Column()
    public name: string;

    @Column()
    public lastName: string;

    @OneToOne(() => User, (user: User) => user.idUser)
    public user: User;
}
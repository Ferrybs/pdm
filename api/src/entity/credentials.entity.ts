import { Column, Entity, OneToOne, PrimaryColumn } from "typeorm";
import User from "./client.entity";

@Entity()
export default class Credentials{
    @PrimaryColumn()
    public email: string;

    @Column()
    public password?: string;

    @OneToOne(() => User, user => user.idUser)
    public user: User;
}
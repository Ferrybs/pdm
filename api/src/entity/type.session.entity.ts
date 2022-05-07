import { Column, Entity,OneToMany, PrimaryGeneratedColumn } from "typeorm";
import Sessions from "./sessions.entity";

@Entity()
export default class TypeSession{
    @PrimaryGeneratedColumn("increment")
    public id?: string;

    @Column({unique: true})
    public type?: string;

    @OneToMany(() => Sessions, sessions => sessions.type, {cascade: true})
    public sessions: Sessions[];
}
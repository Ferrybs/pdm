import { Column, Entity, ManyToOne, OneToMany, PrimaryColumn } from "typeorm";
import Client from "./client.entity";
import Measure from "./measure.entity";

@Entity()
export default class Device{

    @PrimaryColumn()
    public id?: string;

    @Column()
    public name?: string;

    @OneToMany(() => Measure, measure => measure.device, {cascade: true})
    public measures?: Measure[];

    @ManyToOne(() => Client, client => client.devices)
    public client?: Client;



}
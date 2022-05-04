import { Column, Entity, ManyToOne, OneToMany, PrimaryColumn } from "typeorm";
import Client from "./client.entity";
import Measure from "./measure.entity";

@Entity()
export default class Device{

    @PrimaryColumn()
    public id: string;

    @Column()
    public name: string;

    @OneToMany(() => Measure, (measure: Measure) => measure.device, {cascade: true})
    public measures?: Measure[];

    @ManyToOne(() => Client, client => client.id)
    public client?: Client;



}
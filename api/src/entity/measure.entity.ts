import { Column, Entity, ManyToOne, OneToMany, OneToOne, PrimaryColumn } from "typeorm";
import Device from "./device.entiy";
import TypeMeasure from "./type.measure.entity";

@Entity()
export default class Measure{

    @PrimaryColumn()
    public id?: string;

    @Column({type: "timestamptz", nullable: false})
    public date?: Date;

    @Column({nullable: false})
    public value?: string;

    @ManyToOne(() => Device, device => device.measures)
    public device?: Device;

    @ManyToOne(() => TypeMeasure, type => type.type)
    public type?: TypeMeasure; 

}
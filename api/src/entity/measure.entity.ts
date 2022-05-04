import { Column, Entity, ManyToOne, OneToMany, OneToOne, PrimaryColumn } from "typeorm";
import Device from "./device.entiy";
import TypeMeasure from "./type.measure.entity";

@Entity()
export default class Measure{

    @PrimaryColumn()
    public id: string;

    @Column({type: "timestamptz", nullable: false})
    public date?: Date;

    @ManyToOne(() => Device, device => device.id)
    public device?: Device;

    @OneToMany(() => TypeMeasure, (type: TypeMeasure) => type.measure, {cascade: true})
    public types?: TypeMeasure[]; 

}
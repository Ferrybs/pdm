import { Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryColumn, PrimaryGeneratedColumn } from "typeorm";
import Measure from "./measure.entity";

@Entity()
export default class TypeMeasure{
    @PrimaryGeneratedColumn("increment")
    public id?: string;

    @Column({unique: true})
    public type?: string;

    @OneToMany(() => Measure, measure => measure.type, {cascade: true})
    public measures: Measure[];
}
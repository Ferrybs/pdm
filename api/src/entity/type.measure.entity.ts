import { Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryColumn } from "typeorm";
import Measure from "./measure.entity";

import ValueMeasure from "./value.measure.entity";

@Entity()
export default class TypeMeasure{
    @PrimaryColumn({generated: "increment"})
    public id: string;

    @Column({unique: true})
    public type?: string;

    @ManyToOne(() => Measure, measure => measure.id)
    public measure: Measure;

    @OneToMany(() => ValueMeasure, (value: ValueMeasure) => value.type)
    public values?: ValueMeasure[];


}
import { Column, Entity, ManyToOne, OneToOne} from "typeorm";
import TypeMeasure from "./type.measure.entity";

@Entity()
export default class ValueMeasure{
    @Column({nullable: false})
    public value: string;

    @ManyToOne(() => TypeMeasure, type => type.id)
    public type: TypeMeasure;
    
}
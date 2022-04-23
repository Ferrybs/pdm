import { Column, Entity, ManyToOne, PrimaryColumn} from "typeorm";
import Client from "./client.entity";

@Entity()
export default class Sessions{    
    
    @PrimaryColumn()
    public id: string;

    @Column({nullable:false})
    public type: string;

    @Column()
    public description?: string;

    @Column({nullable:false})
    public iat: number;

    @Column({nullable:false})
    public expiresIn: number;

    @ManyToOne(() => Client, client => client.id)
    public client?: Client;
}
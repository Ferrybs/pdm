import { Column, Entity, ManyToOne, PrimaryColumn} from "typeorm";
import Client from "./client.entity";

@Entity()
export default class Sessions{    
    
    @PrimaryColumn()
    public id?: string;

    @Column()
    public description?: string;

    @Column()
    public iat?: number;

    @Column()
    public expiresIn?: number;

    @ManyToOne(() => Client, client => client.id)
    public client?: Client;
}
import { Column, Entity, ManyToOne, PrimaryColumn} from "typeorm";
import Client from "./client.entity";
import TypeSession from "./type.session.entity";

@Entity()
export default class Sessions{    
    
    @PrimaryColumn()
    public id?: string;

    @Column()
    public description?: string;

    @Column({nullable:false})
    public iat?: number;

    @Column({nullable:false})
    public expiresIn?: number;

    @ManyToOne(() => TypeSession, type => type.sessions)
    public type?: TypeSession; 

    @ManyToOne(() => Client, client => client.sessions)
    public client?: Client;
}
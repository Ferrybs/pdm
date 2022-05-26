import { Column, Entity, PrimaryColumn } from "typeorm";

@Entity()
export default class MqttServer {
    @PrimaryColumn({nullable: false})
    public id?: string;
    @Column({nullable: false, unique: true})
    public server?: string;
    @Column({nullable: false, unique: true})
    public user?: string;
    @Column({nullable: false})
    public password?: string;
    @Column({nullable: false, width: 4})
    public port?: string;
}
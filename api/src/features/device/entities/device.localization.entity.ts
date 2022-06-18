import { Column, Entity, JoinColumn, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import Device from "./device.entity";

@Entity()
export default class DeviceLocalization{
    @PrimaryGeneratedColumn("uuid")
    public id?: string;
    @Column({nullable: false, type: "double precision"})
    public latitude?: number;

    @Column({nullable: false, type: "double precision"})
    public longitude?: number;

    @OneToOne(() => Device, device => device, {nullable: false})
    @JoinColumn()
    public device?: Device;
}
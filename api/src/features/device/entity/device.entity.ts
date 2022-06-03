import { Column, Entity, JoinColumn, ManyToOne, OneToMany, OneToOne, PrimaryColumn } from "typeorm";
import Client from "../../../entity/client.entity";
import DeviceLocalization from "./device.localization.entity";
import DevicePreferences from "./device.preferences.entity";
import Measure from "./measure.entity";

@Entity()
export default class Device{

    @PrimaryColumn()
    public id?: string;

    @Column({default: "Esp32"})
    public name?: string;

    @OneToMany(() => Measure, measure => measure.device,{cascade:true})
    public measures?: Measure[];

    @ManyToOne(() => Client, client => client.devices, {nullable: false})
    public client?: Client;

    @OneToOne(() => DevicePreferences, (preferences: DevicePreferences) => preferences.device,{cascade:true})
    public preferences?: DevicePreferences;

    @OneToOne(() => DeviceLocalization, (localization: DeviceLocalization) => localization.device,{cascade:true})
    public localization?: DeviceLocalization;



}
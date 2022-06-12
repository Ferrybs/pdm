import DevicePreferencesDTO from "../device/dto/device.preferences.dto";
import client  from "../../configs/mqtt.config";
import Measure from "../../features/device/entities/measure.entity";
import Device from "../../features/device/entities/device.entity";
import TypeMeasure from "../../features/device/entities/type.measure.entity";
import Client from "../../features/client/entities/client.entity";
import { plainToInstance } from "class-transformer";
import { DataSource } from "typeorm";
import MqttDatabase from "./interfaces/mqtt.database.interface";
import MqttPostgresDatabase from "./database/mqtt.postgres.database";

export default class MqttServer {
    private _mqqtClient = client;
    private _database: MqttDatabase;
    constructor(_appDataSource: DataSource){
        this._database = new MqttPostgresDatabase(_appDataSource);
        this.start();
        this.setup();
    }
    private async setup(){
        this._mqqtClient.on("connect",()=>{
            console.log("Mqtt Connected!");
        });
        this._mqqtClient.subscribe("device");

        }
    private async addMeasure(measure: Measure){
        await this._database.insertMeasure(measure);
    }
    private async start(): Promise<void> {
        try {
            this._mqqtClient.on("message",async (topic,payload)=>{
                var device: Device;
                var measure: Measure;
                var message: any;
                try {
                    message = JSON.parse(payload.toString());
                } catch (error) {
                    console.log("MQTT WRONG JSON: "+error.message)
                } 
                if (topic === "device" && message != null) {
                    try {
                        device = this.plainToDevice(message["deviceDTO"]);
                        console.log(device);
                    } catch (error) {
                        console.log("MQTT ERROR: ",error.message);
                    }
                    if (device) {
                        try {
                            await this._database.saveDevice(device);
                        } catch (error) {
                            console.log("MQTT DATABASE ERROR: ",error.message);
                        }
                    }else{
                        console.log("MQTT DEVICE NULL!");
                    }
                }
                if (topic === "measure" && message != null) {
                    try {
                        measure = this.plainToMeasure(message["measureDTO"]);
                        console.log(measure);
                    } catch (error) {
                        console.log("MQTT ERROR: ",error.message);
                    }
                    if (measure) {
                        try {
                            await this.addMeasure(measure);
                        } catch (error) {
                            console.log("MQTT DATABASE ERROR: ",error.message);
                        }
                    }else{
                        console.log("MQTT MEASURE NULL!");
                    }
                }
            }
        );
        } catch (error) {
            console.log("MQTT ERROR: "+error.message);
        }
    }
    private plainToDevice(message: any){
        const device = new Device();
        try {
            device.client = plainToInstance(Client,message["clientDTO"]);
            device.id = message["id"].toString();
            device.name = message["name"].toString();
            return device;
        } catch (error) {
            throw new Error("Wrong Type Of Message Recived!"+ error.message);
        }
    }
    public postDevicePreferences(deviceId: string ,devicePreferencesDTO: DevicePreferencesDTO) {
        this._mqqtClient.publish(`${deviceId}/settings`,JSON.stringify(devicePreferencesDTO));
    }
    private plainToMeasure(message: any): Measure {
        const measure = new Measure();
        const type = new TypeMeasure();
        const device = new Device();
        try {
            type.id = message["typeDTO"]["id"].toString();
            device.id = message["deviceDTO"]["id"].toString();
            measure.date = new Date(message["date"]);
            measure.value = message["value"].toString();
            measure.device = device;
            measure.type = type;
        } catch (error) {
            throw new Error("Wrong Type Of Message Recived!"+ error.message);
        }

        return measure;
    }
}
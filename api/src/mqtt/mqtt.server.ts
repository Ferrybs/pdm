import PostgresDatabase from "../database/postgres.database";
import DevicePreferencesDTO from "../dto/device.preferences.dto";
import Measure from "../entity/measure.entity";
import Database from "../interfaces/database.interface";
import { mqttClient } from "../configs/mqtt.config";
import Device from "../entity/device.entiy";
import TypeMeasure from "../entity/type.measure.entity";

export default class MqttServer {
    private _mqqtClient = mqttClient;
    private _database: Database;
    constructor(database: Database){
        this._database = database;
        this.start();
    }

    private async addMeasure(measure: Measure){
        await this._database.insertMeasure(measure);
    }

    private async start(): Promise<void> {
        try {
            this._mqqtClient.on("message",async (topic,payload)=>{
                var measure: Measure;
                const message: any = JSON.parse(payload.toString());
                if (topic  === "measure" && message["ok"]) {
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
                
            })
        } catch (error) {
            console.log(error.message);
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
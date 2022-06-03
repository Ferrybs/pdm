import DevicePreferencesDTO from "../device/dto/device.preferences.dto";
import { mqttClient } from "../../configs/mqtt.config";
import DeviceDatabase from "../../features/device/interfaces/device.database.interface";
import Measure from "../../features/device/entities/measure.entity";
import Device from "../../features/device/entities/device.entity";
import TypeMeasure from "../../features/device/entities/type.measure.entity";

export default class MqttServer {
    private _mqqtClient = mqttClient;
    private _database: DeviceDatabase;
    constructor(database: DeviceDatabase){
        this._database = database;
        this.start();
    }

    private async addMeasure(measure: Measure){
        await this._database.insertMeasure(measure);
    }

    private async start(): Promise<void> {
        try {
            this._mqqtClient.on()
            this._mqqtClient.on("message",async (topic,payload)=>{
                var message: any;
                var measure: Measure;
                try {
                    message = JSON.parse(payload.toString());
                } catch (error) {
                    console.log("MQTT WRONG JSON ON PAYLOAD!");
                }
                if (topic  === "measure" && (message != null && message["ok"])) {
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
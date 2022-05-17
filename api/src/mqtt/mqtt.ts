import MqttService from "../services/mqtt.service";
import { mqttClient } from "../configs/mqtt.config";
import DeviceDTO from "../dto/device.dto";
import MeasureDTO from "../dto/measure.dto";
import TypeMeasureDTO from "../dto/type.measure.dto";

export class Mqtt {
    private _mqqtClient = mqttClient;
    private _mqttService = new MqttService();

    public async start(): Promise<void> {
        try {
            this._mqqtClient.on("message",async (topic,payload)=>{
                var measureDTO: MeasureDTO;
                const message: any = JSON.parse(payload.toString());
                if (topic  === "measure" && message["ok"]) {
                    try {
                        measureDTO = this.plainToMeasureDTO(message["measureDTO"]); 
                        console.log(measureDTO);
                    } catch (error) {
                        console.log("MQTT ERROR: ",error.message);
                    }
                    if (measureDTO) {
                        try {
                            await this._mqttService.addMeasure(measureDTO);
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

    private plainToMeasureDTO(message: any): MeasureDTO {
        const measureDTO = new MeasureDTO();
        const typeDTO = new TypeMeasureDTO();
        const deviceDTO = new DeviceDTO();
        try {
            typeDTO.id = message["typeDTO"]["id"].toString();
            deviceDTO.id = message["deviceDTO"]["id"].toString();
            measureDTO.date = new Date(message["date"]);
            measureDTO.value = message["value"].toString();
            measureDTO.deviceDTO = deviceDTO;
            measureDTO.typeDTO = typeDTO;
        } catch (error) {
            throw new Error("Wrong Type Of Message Recived!"+ error.message);
        }

        return measureDTO;
    }
}

import { plainToInstance, TransformPlainToInstance } from "class-transformer";
import MeasureDTO from "../dto/measure.dto";
import mqtt, { MqttClient } from "mqtt";
import validateEnv from "../utils/validateEnv";

const client = mqtt.connect({
    host: validateEnv.MQTT_HOST,
    port: validateEnv.MQTT_PORT,
    protocol: "mqtts",
    username: validateEnv.MQTT_USER,
    password: validateEnv.MQTT_PASS
});

client.on("connect",()=>{
    console.log('MQTT Connected');
 });

client.subscribe("measure");

export const mqttClient: MqttClient = client;
 
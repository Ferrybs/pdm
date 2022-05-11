/*
 * Virtuino MQTT getting started example
 * Broker: HiveMQ (Secure connection)
 * Supported boards: ESP8266 / ESP32 
 * Created by Ilias Lamprou
 * Jul 13 2021
 */
#include <PubSubClient.h>
#include <WiFiClientSecure.h>
#include "server/MqttServer.h"
#include "settings/DeviceSettings.h"

MqttServer mqtt;
DeviceSettings device;

void setup() {
  device.configure();
  mqtt.setup();
  mqtt.connect();
}

void loop() {
}
#include "server/MqttServer.h"
#include "settings/DeviceSettings.h"

MqttServer mqtt;
ClientSettings prefer;
DeviceSettings device;

void setup() {
  device.configure();
  mqtt.setup();
  delay(500);
  if (!mqtt.isConnected()) mqtt.connect();
  mqtt.loop();
}

void loop() {
}
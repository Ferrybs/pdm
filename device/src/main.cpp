#include "server/MqttServer.h"
#include "settings/DeviceSettings.h"
#include "measures/Humidity.h"

void setup() {
  device.configure();
  mqtt.setup();
  delay(500);
}

void loop() {
  if (device.isConnected())
  {
    if (mqtt.isConnected())
    {
      mqtt.postMeasure(humidity.getHumidity(),1);
      mqtt.loop();
    }else{
      mqtt.connect();
    }
  }else{
    device.configure();
  }
  
}
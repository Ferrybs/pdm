#include "server/MqttServer.h"
#include "settings/DeviceSettings.h"
#include "measures/Measure.h"
#include "controllers/Controller.h"

void setup() {
  device.configure();
  mqtt.setup();
  delay(500);
}
void loop() {
  float temperature = measure.getTemperature();
  if (device.isConnected())
  {
    if (mqtt.isConnected())
    {
      mqtt.postMeasure(temperature,1);
      //mqtt.postMeasure(measure.getHumidity(),2);
      //mqtt.postMeasure(measure.getLumiosity(),3);
      //mqtt.postMeasure(measure.getMoisture(),4);
      mqtt.loop();
    }else{
      mqtt.connect();
    }
  }else{
    device.configure();
  }
  controller.setTemperature(temperature);
}
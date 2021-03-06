#include "server/MqttServer.h"
#include "settings/DeviceSettings.h"
#include "measures/Measure.h"
#include "controllers/MeasureController.h"
#include "controllers/LocalizationController.h"
void setup() {
  device.configure();
  mqtt.setup();
  delay(500);
  if (device.isConnected()&& mqtt.isConnected())
  {
    mqtt.postDevice();
    location_t loc = localizationController.getLocalization();
    mqtt.postLocalization(loc.lat,loc.lon);
  }else{
    ESP.restart();
  }
  console.ledOff();
}
void loop() {
  float temperature = measure.getTemperature();
  float humidity = measure.getHumidity();
  float luminosity = measure.getLumiosity();
  float moisture = measure.getMoisture();
  if (device.isConnected())
  {
    if (mqtt.isConnected())
    {
      mqtt.postMeasure(temperature,1);
      mqtt.postMeasure(humidity,2);
      mqtt.postMeasure(luminosity,3);
      mqtt.postMeasure(moisture,4);
      mqtt.loop();
    }else{
      mqtt.connect();
    }
  }else{
    device.configure(true);
  }
  measureController.setTemperature(temperature);
  measureController.setHumidity(humidity);
  measureController.setLuminosity(luminosity);
  measureController.setMoisture(moisture);
}
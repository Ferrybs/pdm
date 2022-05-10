#include <Arduino.h>
#include <WiFi.h>
#include "settings/DeviceSettings.h"
#include "measures/Humidity.h"


using namespace std;

DeviceSettings  device;
Humidity humidity;


void setup() {
    device.configure();
}

void loop() {
    if (device.isConnected())
    {
        humidity.getHumidity();
    }
    
}
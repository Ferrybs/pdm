#include <Arduino.h>
#include <WiFi.h>
#include "settings/DeviceSettings.h"
#include "measures/Humidity.h"


using namespace std;

DeviceSettings  device;
Humidity humidity;


void setup() {
  Serial.begin(9600);
  pinMode(2,OUTPUT);
  Serial.println();
  device.configure();
  Serial.println("IS CONNECTED");
  Serial.println(device.isConnected());

}

void loop() {
  if (device.isConnected()){
    humidity.getHumidity();
  }else{
    device.configure();
  }
  
}
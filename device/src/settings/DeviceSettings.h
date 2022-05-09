#include <Arduino.h>
#include <WiFi.h>
#include "connections/WifiAccessPoint.h"
#include "connections/WifiNetwork.h"
#include "server/HttpServer.h"


class DeviceSettings
{
private:
    ClientSettings preferences;
    WifiAccessPoint ap;
    WifiNetwork network;
    HttpServer http; 
public:
    void configure();
    bool isConnected();
};
bool DeviceSettings::isConnected(){
    return network.isConnected();
}
void DeviceSettings::configure(){
    
    if (!preferences.isConfigured())
    {
        digitalWrite(2,HIGH);
        ap.start();
        http.start();
        digitalWrite(2,LOW);
        delay(500);
        digitalWrite(2,HIGH);
        Serial.println("Starting Access Point...");
        while (!preferences.isConfigured()){
            http.run();
        }
        digitalWrite(2,LOW);
        ap.stop();
        http.stop();
        digitalWrite(2,HIGH);
    }
    if (!network.start())
    {
        digitalWrite(2,LOW);
        Serial.println("Failed to connect!");
        preferences.putConfigured(false);
        digitalWrite(2,HIGH);
        configure();
    }
    digitalWrite(2,LOW);
    Serial.println("Device configured successfully!");

}

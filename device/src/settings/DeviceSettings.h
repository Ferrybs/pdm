#include <Arduino.h>
#include <WiFi.h>
#include "connections/WifiAccessPoint.h"
#include "connections/WifiNetwork.h"
#include "server/HttpServer.h"
#include "core/Console.h"
class DeviceSettings
{
private:
public:
    void configure();
    bool isConnected();
};
bool DeviceSettings::isConnected(){
    return wifiNetwork.isConnected();
}
void DeviceSettings::configure(){
    console.ledOn();
    console.log("Starting configuration!");
    if (!preferences.isConfigured())
    {
        console.blink();
        wifiAccessPoint.start();
        http.start();
        console.blink();
        console.blink();
        console.log("Starting Access Point...");
        while (!preferences.isConfigured()){
            http.run();
        }
        console.blink();
        wifiAccessPoint.stop();
        http.stop();
    }
    if (!wifiNetwork.start())
    {
        console.blink();
        console.log("Failed to connect!");
        preferences.putConfigured(false);
        console.blink();
        configure();
    }
    console.log("Device configured successfully!");
    console.ledOff();

}

DeviceSettings device;

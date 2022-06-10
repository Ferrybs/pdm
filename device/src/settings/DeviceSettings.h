#include <Arduino.h>
#include <WiFi.h>
#include "connections/WifiNetwork.h"
#include "core/Console.h"
#include "server/BTServer.h"
class DeviceSettings
{
private:
public:
    void configure();
    bool isConnected();
    bool isPosted();
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
        btserver.setup();
        while (!isDeviceConfig){
            btserver.run();
        }
        console.blink();
    }
    if (!wifiNetwork.start())
    {
        console.blink();
        console.log("Failed to connect!");
        preferences.putConfigured(false);
        isDeviceConfig=false;
        console.blink();
        ESP.restart();
    }
    btserver.setConfigured(true);
    preferences.putConfigured(true);
    console.blink(10);
    btserver.stop();
    console.log("Device configured successfully!");
    console.ledOff();

}

bool DeviceSettings::isPosted(){
    return preferences.isPosted();
}

DeviceSettings device;

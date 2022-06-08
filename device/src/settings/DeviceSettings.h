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
        while (!preferences.isConfigured()){
            btserver.run();
        }
        btserver.stop();
        console.blink();
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

bool DeviceSettings::isPosted(){
    return preferences.isPosted();
}

DeviceSettings device;

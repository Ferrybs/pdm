#include <WiFi.h>
#include "settings/ClientSettings.h"
#include "core/Console.h"
class WifiNetwork{
private:
public:
    bool start(bool inLoop=false);
    bool isConnected();
};
bool WifiNetwork::isConnected(){
    return WiFi.isConnected();
}
bool WifiNetwork::start(bool inLoop){
    int count = 0;
    String ssid, password;
    digitalWrite(2,LOW);
    WiFi.mode(WIFI_MODE_STA);
    console.blink();
    ssid = preferences.getSSID();
    password = preferences.getPassword();
    WiFi.begin(ssid.c_str(),password.c_str());
    console.log("Try to connect to WiFi ..",false);
    digitalWrite(2,HIGH);
    while (WiFi.status() != WL_CONNECTED && count < 9) {
        console.log(".",false);
        digitalWrite(2,HIGH);
        console.blink(2,300);
        digitalWrite(2,LOW);
        console.blink(2,300);
        count++;
    }
    console.log();
    if (WiFi.status() != WL_CONNECTED)
    {
        if (inLoop)
        {
            ESP.restart();
        }
        return false;
    }else{
        console.log("Connected!",false);
        console.log("IP: ",false);
        console.log(WiFi.localIP());
        return true;
    }
}

WifiNetwork wifiNetwork;
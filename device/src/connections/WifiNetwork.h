#include <WiFi.h>
#include "settings/ClientSettings.h"
class WifiNetwork{
private:
    ClientSettings preferences;
public:
    bool start();
    bool isConnected();
};
bool WifiNetwork::isConnected(){
    return WiFi.isConnected();
}
bool WifiNetwork::start(){
    int count = 0;
    String ssid, password;
    digitalWrite(2,LOW);
    WiFi.mode(WIFI_MODE_STA);
    delay(300);
    ssid = preferences.getSSID();
    password = preferences.getPassword();
    WiFi.begin(ssid.c_str(),password.c_str());
    Serial.print("Try to connect to WiFi ..");
    digitalWrite(2,HIGH);
    while (WiFi.status() != WL_CONNECTED && count < 40) {
        Serial.print('.');
        digitalWrite(2,HIGH);
        delay(rand() % 500);
        digitalWrite(2,LOW);
        delay(rand() % 500);
        count++;
    }
    Serial.println();
    if (count == 40 && WiFi.status() != WL_CONNECTED)
    {
        return false;
    }else{
        Serial.println("Connected!");
        Serial.print("IP: ");
        Serial.println(WiFi.localIP());
        return true;
    }
}

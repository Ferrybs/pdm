#include <WiFi.h>
class WifiAccessPoint{
private:
    const char* _ssid     = "ESP32-Access-Point";
    const char* _password = "123456789";
public:
    void start();
    IPAddress getIp();
    void stop();
    bool status();
};

void WifiAccessPoint::start(){
    IPAddress local_IP(10,0,0,1);
    IPAddress gateway(10,0,0,2);
    IPAddress subnet(255,255,255,0);
    delay(200);
    WiFi.mode(WIFI_MODE_AP);
    WiFi.softAPConfig(local_IP,gateway,subnet);
    delay(500);
    WiFi.softAP(_ssid,_password);
    delay(500);
}
IPAddress WifiAccessPoint::getIp(){
    return WiFi.softAPIP();
}
void WifiAccessPoint::stop(){
    WiFi.softAPdisconnect(true);
}

bool WifiAccessPoint::status(){
    return WiFi.softAPIP() != IPAddress(0,0,0,0);
}

WifiAccessPoint wifiAccessPoint;

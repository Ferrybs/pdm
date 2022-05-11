#include <PubSubClient.h>
#include <WiFiClientSecure.h>
#include "settings/ClientSettings.h"
#include <ArduinoJson.h>
#include "core/Console.h"

WiFiClientSecure espClient;   // for no secure connection use WiFiClient instead of WiFiClientSecure 
PubSubClient client(espClient);

char buffer[1024];
DynamicJsonDocument json(1024);
class MqttServer
{
private:
    ClientSettings preferences;
    Console console;
public:
    bool isConnected();
    void setup();
    void loop();
    void postMeasure(float value,int type);
};
void MqttServer::postMeasure(float value,int type){
    json.clear();
    if(value != NULL){
        json["ok"] = true;
        json["value"] = value;
        JsonObject deviceDTO = json.createNestedObject("measureDTO");
        JsonObject typeDTO = json.createNestedObject("typeDTO");
        typeDTO["id"] = type;
        deviceDTO["id"] = preferences.getId();
    }else{
        json["ok"] = false;
        json["message"] = "Value is null!";
    }
    serializeJson(json, buffer);
}
void MqttServer::setup(){
    espClient.setCACert(preferences.getMqttCert().c_str());
    client.setServer(preferences.getMqttServer().c_str(),preferences.getMqttPort());
    if (
        client.connect(preferences.getId().c_str(),
        preferences.getMqttUser().c_str(),
        preferences.getMqttPassword().c_str())
    )
    {
        console.log("Mqtt Connected!");
    }
    
}
void MqttServer::loop(){
    client.loop();
}

bool MqttServer::isConnected(){
    return client.connected();
}

#include <PubSubClient.h>
#include <WiFiClientSecure.h>
#include <ezTime.h>
#include "settings/ClientSettings.h"
#include <ArduinoJson.h>
#include "core/Console.h"


static const char *root_ca PROGMEM = R"EOF(
-----BEGIN CERTIFICATE-----
MIIFazCCA1OgAwIBAgIRAIIQz7DSQONZRGPgu2OCiwAwDQYJKoZIhvcNAQELBQAw
TzELMAkGA1UEBhMCVVMxKTAnBgNVBAoTIEludGVybmV0IFNlY3VyaXR5IFJlc2Vh
cmNoIEdyb3VwMRUwEwYDVQQDEwxJU1JHIFJvb3QgWDEwHhcNMTUwNjA0MTEwNDM4
WhcNMzUwNjA0MTEwNDM4WjBPMQswCQYDVQQGEwJVUzEpMCcGA1UEChMgSW50ZXJu
ZXQgU2VjdXJpdHkgUmVzZWFyY2ggR3JvdXAxFTATBgNVBAMTDElTUkcgUm9vdCBY
MTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAK3oJHP0FDfzm54rVygc
h77ct984kIxuPOZXoHj3dcKi/vVqbvYATyjb3miGbESTtrFj/RQSa78f0uoxmyF+
0TM8ukj13Xnfs7j/EvEhmkvBioZxaUpmZmyPfjxwv60pIgbz5MDmgK7iS4+3mX6U
A5/TR5d8mUgjU+g4rk8Kb4Mu0UlXjIB0ttov0DiNewNwIRt18jA8+o+u3dpjq+sW
T8KOEUt+zwvo/7V3LvSye0rgTBIlDHCNAymg4VMk7BPZ7hm/ELNKjD+Jo2FR3qyH
B5T0Y3HsLuJvW5iB4YlcNHlsdu87kGJ55tukmi8mxdAQ4Q7e2RCOFvu396j3x+UC
B5iPNgiV5+I3lg02dZ77DnKxHZu8A/lJBdiB3QW0KtZB6awBdpUKD9jf1b0SHzUv
KBds0pjBqAlkd25HN7rOrFleaJ1/ctaJxQZBKT5ZPt0m9STJEadao0xAH0ahmbWn
OlFuhjuefXKnEgV4We0+UXgVCwOPjdAvBbI+e0ocS3MFEvzG6uBQE3xDk3SzynTn
jh8BCNAw1FtxNrQHusEwMFxIt4I7mKZ9YIqioymCzLq9gwQbooMDQaHWBfEbwrbw
qHyGO0aoSCqI3Haadr8faqU9GY/rOPNk3sgrDQoo//fb4hVC1CLQJ13hef4Y53CI
rU7m2Ys6xt0nUW7/vGT1M0NPAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNV
HRMBAf8EBTADAQH/MB0GA1UdDgQWBBR5tFnme7bl5AFzgAiIyBpY9umbbjANBgkq
hkiG9w0BAQsFAAOCAgEAVR9YqbyyqFDQDLHYGmkgJykIrGF1XIpu+ILlaS/V9lZL
ubhzEFnTIZd+50xx+7LSYK05qAvqFyFWhfFQDlnrzuBZ6brJFe+GnY+EgPbk6ZGQ
3BebYhtF8GaV0nxvwuo77x/Py9auJ/GpsMiu/X1+mvoiBOv/2X/qkSsisRcOj/KK
NFtY2PwByVS5uCbMiogziUwthDyC3+6WVwW6LLv3xLfHTjuCvjHIInNzktHCgKQ5
ORAzI4JMPJ+GslWYHb4phowim57iaztXOoJwTdwJx4nLCgdNbOhdjsnvzqvHu7Ur
TkXWStAmzOVyyghqpZXjFaH3pO3JLF+l+/+sKAIuvtd7u+Nxe5AW0wdeRlN8NwdC
jNPElpzVmbUq4JUagEiuTDkHzsxHpFKVK7q4+63SM1N95R1NbdWhscdCb+ZAJzVc
oyi3B43njTOQ5yOf+1CceWxG1bQVs5ZufpsMljq4Ui0/1lvh+wjChP4kqKOJ2qxq
4RgqsahDYVvTH9w7jXbyLeiNdd8XM2w9U/t7y0Ff/9yi0GE44Za4rF2LN9d11TPA
mRGunUHBcnWEvgJBQl9nJEiU0Zsnvgc/ubhPgXRR4Xq37Z0j4r7g1SgEEzwxA57d
emyPxgcYxn/eR44/KJ4EBs+lVDR3veyJm+kXQ99b21/+jh5Xos1AnX5iItreGCc=
-----END CERTIFICATE-----
)EOF";

WiFiClientSecure espClient;
PubSubClient client(espClient);
Timezone myTZ;
DynamicJsonDocument json(4096);

void callback(char* topic, byte* payload, unsigned int length) {
    DynamicJsonDocument jsonIn(4096);
    char buffer[4096];
    deserializeJson(jsonIn, payload, length);
    preferences.putHumidity(jsonIn["humidity"]);
    preferences.putTemperature(jsonIn["temperature"]);
    preferences.putLuminosity(jsonIn["luminosity"]);
    preferences.putMoisture(jsonIn["moisture"]);
    serializeJson(jsonIn,buffer);
    console.log("["+String(topic)+"]:"+ String(buffer));
}
class MqttServer
{
private:
    char buffer[4096];
    const char *_measure = "measure";
    const char *_localization = "localization";
    const char *_device = "device";
    const char *_settings = "settings";
public:
    boolean isConnected();
    void setup();
    void loop();
    boolean postMeasure(float value,int type);
    boolean postLocalization(float latitude, float longitude);
    boolean postDevice();
    boolean connect();
    };
boolean MqttServer::postLocalization(float latitude, float longitude){
    memset(buffer,0,sizeof(buffer));
    json.clear();
    console.log("Posting Localization...");
    json["ok"] = true;
    JsonObject deviceLocalizationDTO = json.createNestedObject("deviceLocalizationDTO");
    JsonObject deviceDTO = deviceLocalizationDTO.createNestedObject("deviceDTO");
    deviceDTO["id"] = preferences.getId();
    deviceLocalizationDTO["latitude"] = latitude;
    deviceLocalizationDTO["longitude"] = longitude;
    serializeJson(json, buffer); 
    console.log("message[/"+String(this->_localization)+"]: ",false);
    console.log(buffer);
    return client.publish(this->_localization,buffer,false);
    

}
boolean MqttServer::postDevice(){
    memset(buffer,0,sizeof(buffer));
    json.clear();
    console.log("Posting Device...");
    json["ok"] = true;
    JsonObject deviceDTO = json.createNestedObject("deviceDTO");
    JsonObject clientDTO = deviceDTO.createNestedObject("clientDTO");
    deviceDTO["id"] = preferences.getId();
    deviceDTO["name"] = preferences.getName();
    clientDTO["id"] = preferences.getClientId();
    serializeJson(json, buffer); 
    console.log("message[/"+String(this->_device)+"]: ",false);
    console.log(buffer);
    bool status = client.publish(this->_device,buffer,false);
    if (status)
    {
        preferences.putPosted(true);
    }
    return status;
    
}
boolean MqttServer::postMeasure(float value,int type){
    boolean status = false;
    memset(buffer,0,sizeof(buffer));
    json.clear();
    console.log("Posting Measure...");
    if(!isnan(value)){
        json["ok"] = true;
        JsonObject measureDTO = json.createNestedObject("measureDTO");
        JsonObject typeDTO = measureDTO.createNestedObject("typeDTO");
        JsonObject deviceDTO = measureDTO.createNestedObject("deviceDTO");
        typeDTO["id"] = type;
        deviceDTO["id"] = preferences.getId();
        measureDTO["value"] = value;
        waitForSync();
        measureDTO["date"] = UTC.dateTime(RFC822);
        serializeJson(json, buffer);
        // console.log("message["+String(type)+"]: ",false);
        // console.log(buffer);
        status = client.publish(this->_measure,buffer,false);
        if (status)
        {
            console.log("Type["+String(type) +"]: "+String(value));
        }
        
    }
    console.log("Status:",false);
    console.log(status ? " Message send!": " Message was Not Send!");
    
    memset(buffer,0,sizeof(buffer));
    json.clear();
    return status;
}
void MqttServer::setup(){
    espClient.stop();
    espClient.setCACert(root_ca);
    espClient.setHandshakeTimeout(30);
    String host = preferences.getMqttServer();
    static char pHost[64] = {0};
    strcpy(pHost, host.c_str());
    client.setBufferSize(4096);
    client.setServer(pHost, 8883);
    client.setCallback(callback);
    console.blink();
    delay(1000);
    connect();
}
boolean MqttServer::connect(){
    int count = 0;
    while (!client.connected() && count<5) {
        count++;
        console.log("Attempting MQTT connection...",false);
        
        if (client.connect(preferences.getId().c_str(),
            preferences.getMqttUser().c_str(),
            preferences.getMqttPassword().c_str(),
            NULL, 2, false, NULL)
         ) {
            Serial.println("connected");
            String url = preferences.getId()+"/"+this->_settings;
            client.subscribe(url.c_str());
            return true;
        } else {
            console.log("failed, rc=",false);
            console.log(client.state());
            console.log("try again in 2 seconds");
            console.log("Count: ",false);
            console.log(count,false);
            console.log(" Up to 5 ",false);
            console.blink(5);
            //retirar depois que o bug for corrigido
            if (count ==5)
            {
                ESP.restart();
            }
        }
  }
  return client.connected();
}
void MqttServer::loop(){
    client.loop();
}

boolean MqttServer::isConnected(){
    return client.connected();
}

MqttServer mqtt;

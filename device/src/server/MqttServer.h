#include <PubSubClient.h>
#include <WiFiClientSecure.h>
#include <ezTime.h>
#include "settings/ClientSettings.h"
#include <ArduinoJson.h>
#include "core/Console.h"

WiFiClientSecure espClient;
PubSubClient client(espClient);
Timezone myTZ;
DynamicJsonDocument json(4096);

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

void callback(char* topic, byte* payload, unsigned int length) {
    DynamicJsonDocument jsonIn(4096);
    deserializeJson(jsonIn, payload, length);
    preferences.putHumidity(jsonIn["preferencesDTO"]["humidity"]);
    preferences.putTemperature(jsonIn["preferencesDTO"]["temperature"]);
    preferences.putLuminosity(jsonIn["preferencesDTO"]["luminosity"]);
    preferences.putMoisture(jsonIn["preferencesDTO"]["moisture"]);
    console.log("["+String(topic)+"]:"+String((char*)payload));
}
class MqttServer
{
private:
    char buffer[4096];
    const char *_measure = "measure";
    const char *_settings = "settings";
    ClientSettings preferences;
public:
    boolean isConnected();
    void setup();
    void loop();
    boolean postMeasure(float value,int type);
    boolean connect();
    };

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
        size_t n = serializeJson(json, buffer);
        console.log("message["+String(type)+"]: ",false);
        console.log(buffer);
        status = client.publish(this->_measure,buffer,n);
    }
    console.log("Status:",false);
    console.log(status ? "Message send!": "Message was Not Send!");
    
    memset(buffer,0,sizeof(buffer));
    json.clear();
    return status;
}
void MqttServer::setup(){
    espClient.setCACert(root_ca);
    String host = preferences.getMqttServer();
    static char pHost[64] = {0};
    strcpy(pHost, host.c_str());
    client.setBufferSize(4096);
    client.setServer(pHost, preferences.getMqttPort());
    client.setCallback(callback);
}
boolean MqttServer::connect(){
    int count = 0;
    while (!client.connected() && count<50) {
        count++;
        console.log("Attempting MQTT connection...",false);
        if (client.connect(preferences.getId().c_str(),
        preferences.getMqttUser().c_str(),
        preferences.getMqttPassword().c_str())
         ) {
            Serial.println("connected");
            client.subscribe(this->_settings);
            return true;
        } else {
            console.log("failed, rc=",false);
            console.log(client.state());
            console.log("try again in 2 seconds");
            console.blink(20);
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

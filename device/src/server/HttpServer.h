#include <WebServer.h>
#include <ArduinoJson.h>
#include "core/Console.h"

WebServer _server(80);
char buffer[4096];
StaticJsonDocument<4096> jsonDocument;
class HttpServer{
private:
public:
    void start();
    void routes();
    void run();
    void stop();
    static void getId();
    static void postDeviceSettings();
    static void response_id_to_json(bool ok, String id); 
    static void response_message_to_json(bool ok, String message);
    static bool json_to_device_setup();
    
};
void HttpServer::stop(){
    _server.stop();
}
void HttpServer::start(){
    routes();
    _server.begin();
    
}
void HttpServer::getId() {
    console.blink();
    response_id_to_json(true,preferences.getId());
    _server.send(200, "application/json",buffer);
}

bool HttpServer::json_to_device_setup(){
    jsonDocument.clear();
    console.blink();
    bool result = true;
    String body = _server.arg("plain");
    deserializeJson(jsonDocument, body);
    String ssid = jsonDocument["wifiDTO"]["ssid"];
    String password = jsonDocument["wifiDTO"]["password"];
    String mqtt_server = jsonDocument["mqttDTO"]["server"];
    String mqtt_user = jsonDocument["mqttDTO"]["user"];
    String mqtt_password = jsonDocument["mqttDTO"]["password"];
    String mqtt_port = jsonDocument["mqttDTO"]["port"];
    String device_name = jsonDocument["name"];
    String device_key = jsonDocument["key"];
    String client_id = jsonDocument["clientDTO"]["id"];
    console.log("Reciving Wifi Settings...");
    result = ssid == NULL ? false : result;
    result = password == NULL ? false : result;
    result = mqtt_server == NULL ? false : result;
    result = mqtt_user == NULL ? false : result;
    result = mqtt_password == NULL ? false : result;
    result = mqtt_port == NULL ? false : result;
    result = device_name == NULL ? false : result;
    result = device_key == NULL ? false : result;
    result = client_id == NULL ? false : result;
    preferences.putName(device_name);
    preferences.putApiKey(device_key);
    preferences.putClientId(client_id);
    preferences.putMqttServer(mqtt_server);
    preferences.putMqttUser(mqtt_user);
    preferences.putMqttPassword(mqtt_password);
    preferences.putMqttPort(mqtt_port.toInt());
    preferences.putWifiSettings(ssid,password);
    console.log("Settings Configured!");
    return result;
    
    
}

void HttpServer::postDeviceSettings() {
    if (_server.hasArg("plain") == true) {
        console.log();
        if (json_to_device_setup())
        {
            preferences.putConfigured(true);
            response_message_to_json(true,"Device Configured!");
            _server.send(200, "application/json",buffer);
        }else{
            preferences.putConfigured(false);
            response_message_to_json(false,"Error!");
            _server.send(400, "application/json",buffer);
        }
        
    }else{
        response_message_to_json(false,"Body not Found!");
        _server.send(400, "application/json",buffer);
    }
}
void HttpServer::routes(){
    _server.on("/",HTTP_GET,getId);
    _server.on("/",HTTP_POST,postDeviceSettings);
}
void HttpServer::run(){
    _server.handleClient();
}

void HttpServer::response_id_to_json(bool ok, String id){
    jsonDocument.clear(); 
    jsonDocument["ok"] = ok;
    jsonDocument["id"] = id;
    serializeJson(jsonDocument, buffer);
}

void HttpServer::response_message_to_json(bool ok, String message){
    jsonDocument.clear(); 
    jsonDocument["ok"] = ok;
    jsonDocument["message"] = message;
    serializeJson(jsonDocument, buffer);
}

HttpServer http;

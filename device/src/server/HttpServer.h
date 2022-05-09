#include <WebServer.h>
#include <ArduinoJson.h>
WebServer _server(80);
char buffer[512];
StaticJsonDocument<512> jsonDocument;
ClientSettings _preferences;
class HttpServer{
private:
public:
    void start();
    void routes();
    void run();
    void stop();
    static void getId();
    static void postWifiSettings();
    static void response_id_to_json(bool ok, String id); 
    static void response_message_to_json(bool ok, String message);
    static void json_to_credentials_wifi();
    
};
void HttpServer::stop(){
    _server.stop();
}
void HttpServer::start(){
    routes();
    _server.begin();
    
}
void HttpServer::getId() {
    digitalWrite(2,LOW);
    response_id_to_json(true,_preferences.getId());
    digitalWrite(2,HIGH);
    _server.send(200, "application/json",buffer);
}

void HttpServer::json_to_credentials_wifi(){
    jsonDocument.clear(); 
    digitalWrite(2,LOW);
    String body = _server.arg("plain");
    deserializeJson(jsonDocument, body);
    String ssid = jsonDocument["ssid"];
    String password = jsonDocument["password"];
    Serial.println("Reciving Wifi Settings...");
    Serial.println(password);
    _preferences.putWifiSettings(ssid,password);
    digitalWrite(2,HIGH);
}

void HttpServer::postWifiSettings() {
    if (_server.hasArg("plain") == true) {
        Serial.println();
        json_to_credentials_wifi();
        Serial.println("Setting Configured!");
        _preferences.putConfigured(true);
        response_message_to_json(true,"Device Configured!");
        _server.send(200, "application/json",buffer);
    }else{
        response_message_to_json(false,"Body not Found!");
        _server.send(400, "application/json",buffer);
    }
}
void HttpServer::routes(){
    _server.on("/",HTTP_GET,getId);
    _server.on("/",HTTP_POST,postWifiSettings);
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

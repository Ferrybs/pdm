#pragma once
#include <Preferences.h>
#include <iostream>
using namespace std;
class ClientSettings{
private:
    Preferences _preferences;
    const char *_appName  = "esp-32-sensor";
    const char *_ssid = "SSID";
    const char *_password = "PASSWORD";
    const char *_configured = "CONFIGURED";
    const char *_posted = "POSTED";
    const String _id = "3e14e9a9-6378-4c72-876e-ddc43d0a0fd5";
    const char *_name = "NAME";
    const char *_client_id = "CLIENT_ID";
    const char *_api_key = "API_KEY";
    const char *_mqtt_user = "MQTT_USER";
    const char *_mqtt_server = "MQTT_SERVER";
    const char *_mqtt_password = "MQTT_PASSWORD";
    const char *_mqtt_port = "MQTT_PORT";
    const char *_humidity = "humidity";
    const char *_moisture = "moisture";
    const char *_temperature = "temperature";
    const char *_luminosity = "luminosity";
public:
    void putWifiSettings(String ssid, String password);
    void putConfigured(bool status);
    void putPosted(bool posted);
    void putClientId(String id);
    void putHumidity(float humidity);
    void putMoisture(float moisture);
    void putTemperature(float temperature);
    void putLuminosity(float luminosity);
    void putMqttUser(String user);
    void putName(String name);
    void putMqttServer(String server);
    void putMqttPassword(String password);
    void putApiKey(String key);
    void putMqttPort(int port);
    float getTemperature();
    float getLuminosity();
    float getHumidity();
    float getMoisture();
    String getApiKey();
    String getName();
    String getClientId();
    String getSSID();
    String getMqttServer();
    String getMqttUser();
    String getMqttPassword();
    int getMqttPort();
    bool isConfigured();
    bool isPosted();
    String getPassword();
    String getId();
    };
void ClientSettings::putHumidity(float humidity){
    _preferences.begin(this->_appName,false);
    _preferences.putFloat(this->_humidity,humidity);
    _preferences.end();
}
void ClientSettings::putMoisture(float moisture){
    _preferences.begin(this->_appName,false);
    _preferences.putFloat(this->_moisture,moisture);
    _preferences.end();
}
void ClientSettings::putTemperature(float temperature){
    _preferences.begin(this->_appName,false);
    _preferences.putFloat(this->_temperature,temperature);
    _preferences.end();
}
void ClientSettings::putLuminosity(float luminosity){
    _preferences.begin(this->_appName,false);
    _preferences.putFloat(this->_luminosity,luminosity);
    _preferences.end();
}
void ClientSettings::putConfigured(bool status){
    _preferences.begin(this->_appName,false);
    _preferences.putBool(this->_configured,status);
    _preferences.end();
}
void ClientSettings::putPosted(bool posted){
    _preferences.begin(this->_appName,false);
    _preferences.putBool(this->_posted,posted);
    _preferences.end();
}
void ClientSettings::putApiKey(String key){
    _preferences.begin(this->_appName,false);
    _preferences.putString(this->_api_key,key);
    _preferences.end();
}
void ClientSettings::putName(String name){
    _preferences.begin(this->_appName,false);
    _preferences.putString(this->_name,name);
    _preferences.end();
}
void ClientSettings::putClientId(String id){
    _preferences.begin(this->_appName,false);
    _preferences.putString(this->_client_id,id);
    _preferences.end();
}
void ClientSettings::putMqttServer(String server){
    _preferences.begin(this->_appName,false);
    _preferences.putString(this->_mqtt_server,server);
    _preferences.end();
}
void ClientSettings::putMqttUser(String name){
    _preferences.begin(this->_appName,false);
    _preferences.putString(this->_mqtt_user,name);
    _preferences.end();
}
void ClientSettings::putMqttPassword(String password){
    _preferences.begin(this->_appName,false);
    _preferences.putString(this->_mqtt_password,password);
    _preferences.end();
}
void ClientSettings::putMqttPort(int port){
    _preferences.begin(this->_appName,false);
    _preferences.putInt(this->_mqtt_port,port);
    _preferences.end();
}
void ClientSettings::putWifiSettings(String ssid, String password){
    _preferences.begin(this->_appName,false);
    _preferences.putString(this->_ssid,ssid);
    _preferences.putString(this->_password,password);
    _preferences.end();
}
String ClientSettings::getName(){
    String name;
    _preferences.begin(this->_appName,false);
    name = _preferences.getString(this->_name);
    _preferences.end();
    return name;
}
String ClientSettings::getSSID(){
    String SSID;
    _preferences.begin(this->_appName,false);
    SSID = _preferences.getString(this->_ssid);
    _preferences.end();
    return SSID;
}
float ClientSettings::getLuminosity(){
    float luminosity;
    _preferences.begin(this->_appName,false);
    luminosity = _preferences.getFloat(this->_luminosity);
    _preferences.end();
    return luminosity;
}
float ClientSettings::getMoisture(){
    float moisture;
    _preferences.begin(this->_appName,false);
    moisture = _preferences.getFloat(this->_moisture);
    _preferences.end();
    return moisture;
}
float ClientSettings::getTemperature(){
    float temperature;
    _preferences.begin(this->_appName,false);
    temperature = _preferences.getFloat(this->_temperature,NAN);
    _preferences.end();
    return temperature;
}
float ClientSettings::getHumidity(){
    float humidity;
    _preferences.begin(this->_appName,false);
    humidity = _preferences.getFloat(this->_humidity);
    _preferences.end();
    return humidity;
}
String ClientSettings::getMqttServer(){
    String server;
    _preferences.begin(this->_appName,false);
    server = _preferences.getString(this->_mqtt_server);
    _preferences.end();
    return server;
}
String ClientSettings::getMqttUser(){
    String user;
    _preferences.begin(this->_appName,false);
    user = _preferences.getString(this->_mqtt_user);
    _preferences.end();
    return user;
}
String ClientSettings::getMqttPassword(){
    String password;
    _preferences.begin(this->_appName,false);
    password = _preferences.getString(this->_mqtt_password);
    _preferences.end();
    return password;
}
int ClientSettings::getMqttPort(){
    int port;
    _preferences.begin(this->_appName,false);
    port = _preferences.getInt(this->_mqtt_port);
    _preferences.end();
    return port;
}


String ClientSettings::getId(){
    return this->_id;
}


bool ClientSettings::isConfigured(){
    bool status;
    _preferences.begin(this->_appName,false);
    status = _preferences.getBool(this->_configured,false);
    _preferences.end();
    return status;
}

bool ClientSettings::isPosted(){
    bool status;
    _preferences.begin(this->_appName,false);
    status = _preferences.getBool(this->_posted,false);
    _preferences.end();
    return status;
}

String ClientSettings::getPassword(){
    String password;
    _preferences.begin(this->_appName,false);
    password = _preferences.getString(this->_password);
    _preferences.end();
    return password;
}

String ClientSettings::getClientId(){
    String id;
    _preferences.begin(this->_appName,false);
    id = _preferences.getString(this->_client_id);
    _preferences.end();
    return id;
}

String ClientSettings::getApiKey(){
    String key;
    _preferences.begin(this->_appName,false);
    key = _preferences.getString(this->_api_key);
    _preferences.end();
    return key;
}
ClientSettings preferences;

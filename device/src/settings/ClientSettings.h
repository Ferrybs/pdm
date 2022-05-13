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
    const String _id = "3e14e9a9-6378-4c72-876e-ddc43d0a0fd5";
    const char *_mqtt_user = "MQTT_USER";
    const char *_mqtt_server = "MQTT_SERVER";
    const char *_mqtt_password = "MQTT_PASSWORD";
    const char *_mqtt_port = "MQTT_PORT";
public:
    void putWifiSettings(String ssid, String password);
    void putConfigured(bool status);
    void putMqttUser(String user);
    void putMqttServer(String server);
    void putMqttPassword(String password);
    void putMqttPort(int port);
    String getSSID();
    String getMqttServer();
    String getMqttUser();
    String getMqttPassword();
    int getMqttPort();
    bool isConfigured();
    String getPassword();
    String getId();
    };
void ClientSettings::putConfigured(bool status){
    _preferences.begin(this->_appName,false);
    _preferences.putBool(this->_configured,status);
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
String ClientSettings::getSSID(){
    String SSID;
    _preferences.begin(this->_appName,false);
    SSID = _preferences.getString(this->_ssid);
    _preferences.end();
    return SSID;
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

String ClientSettings::getPassword(){
    String password;
    _preferences.begin(this->_appName,false);
    password = _preferences.getString(this->_password);
    _preferences.end();
    return password;
}

ClientSettings preferences;

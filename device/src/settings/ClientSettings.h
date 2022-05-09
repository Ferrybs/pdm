#include <Preferences.h>

class ClientSettings{
private:
    Preferences _preferences;
    const char *_appName  = "esp-32-sensor";
    const char *_ssid = "SSID";
    const char *_password = "PASSWORD";
    const char *_configured = "CONFIGURED";
    const String _id = "3e14e9a9-6378-4c72-876e-ddc43d0a0fd5";
public:
    void putWifiSettings(String ssid, String password);
    void putConfigured(bool status);
    String getSSID();
    bool isConfigured();
    String getPassword();
    String getId();
};
void ClientSettings::putConfigured(bool status){
    _preferences.begin(this->_appName,false);
    _preferences.putBool(this->_configured,status);
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
    delay(200);
    SSID = _preferences.getString(this->_ssid);
    _preferences.end();
    return SSID;
}

String ClientSettings::getId(){
    delay(200);
    return this->_id;
}

bool ClientSettings::isConfigured(){
    bool status;
    _preferences.begin(this->_appName,false);
    delay(200);
    status = _preferences.getBool(this->_configured,false);
    _preferences.end();
    return status;
}

String ClientSettings::getPassword(){
    String password;
    _preferences.begin(this->_appName,false);
    delay(200);
    password = _preferences.getString(this->_password);
    _preferences.end();
    return password;
}

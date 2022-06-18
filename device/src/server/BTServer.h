#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>
#include <core/Console.h>


bool deviceConnected = false;
bool oldDeviceConnected = false;
bool isDeviceConfig= false;
StaticJsonDocument<4096> BTJson;

#define SERVICE_UUID           "6E400001-B5A3-F393-E0A9-E50E24DCCA9E" // UART service UUID
#define CHARACTERISTIC_UUID_RX "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
#define CHARACTERISTIC_UUID_TX "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"


class MyServerCallbacks: public BLEServerCallbacks {
    void onConnect(BLEServer* pServer) {
      deviceConnected = true;
    };

    void onDisconnect(BLEServer* pServer) {
      deviceConnected = false;
    }
};

class MyCallbacks: public BLECharacteristicCallbacks {
    void onWrite(BLECharacteristic *pCharacteristic) {
        std::string rxValue = pCharacteristic->getValue();
        if (rxValue.length() > 0) {
            Serial.println("*********");
            Serial.print("Received Value: ");
            for (int i = 0; i < rxValue.length(); i++)
            Serial.print(rxValue[i]);

            Serial.println();
            Serial.println("*********");
        }
        BTJson.clear();
        console.blink();
        bool result = true;
        deserializeJson(BTJson, rxValue.c_str());
        String ssid = BTJson["wifiDTO"]["ssid"];
        String password = BTJson["wifiDTO"]["password"];
        String mqtt_server = BTJson["mqttDTO"]["server"];
        String mqtt_user = BTJson["mqttDTO"]["user"];
        String mqtt_password = BTJson["mqttDTO"]["password"];
        String mqtt_port = BTJson["mqttDTO"]["port"];
        String device_name = BTJson["name"];
        String device_key = BTJson["key"];
        String client_id = BTJson["id"];
        console.log("Reciving Wifi Settings...");
        result = ssid == "null" ? false : result;
        result = password == "null" ? false : result;
        result = mqtt_server == "null" ? false : result;
        result = mqtt_user == "null" ? false : result;
        result = mqtt_password == "null" ? false : result;
        result = mqtt_port == "null" ? false : result;
        result = device_name == "null" ? false : result;
        result = device_key == "null" ? false : result;
        result = client_id == "null" ? false : result;
        console.log("SSID: "+ ssid);
        console.log("password: "+ password);
        console.log("mqtt_server: "+ mqtt_server);
        console.log("mqtt_user: "+ mqtt_user);
        console.log("mqtt_password: "+ mqtt_password);
        console.log("mqtt_port: "+ mqtt_port);
        console.log("device_name: "+ device_name);
        console.log("device_key: "+ device_key);
        console.log("client_id: "+ client_id);
        if (result)
        {
            preferences.putName(device_name);
            preferences.putApiKey(device_key);
            preferences.putClientId(client_id);
            preferences.putMqttServer(mqtt_server);
            preferences.putMqttUser(mqtt_user);
            preferences.putMqttPassword(mqtt_password);
            preferences.putMqttPort(mqtt_port.toInt());
            preferences.putWifiSettings(ssid,password);
            
        }
        String settings =  result ? "TRUE" : "FALSE";
        console.log("Settings Recived: " + settings);
        
        if (result)
        {
            isDeviceConfig=true;
        }
    }
};

class BTServer
{
private:
    BLEServer *pServer = NULL;
    BLECharacteristic * pTxCharacteristic;
    BLECharacteristic * pRxCharacteristic;
    BLECharacteristic * DeviceConfigCharacteristic;
    char deviceConfigJson[4096];
public:
    void setup(){
        BLEDevice::init("Esp32 Sensor");
        pServer = BLEDevice::createServer();
        pServer->setCallbacks(new MyServerCallbacks());
        BLEDescriptor deviceConfigDescriptor(BLEUUID((uint16_t)0x2903));
        // Create the BLE Service
        BLEService *pService = pServer->createService(SERVICE_UUID);
        // Create a BLE Characteristic
        pTxCharacteristic = pService->createCharacteristic(
                                                CHARACTERISTIC_UUID_TX,
                                                BLECharacteristic::PROPERTY_READ
                                            );      
        pTxCharacteristic->addDescriptor(&deviceConfigDescriptor);

        pRxCharacteristic = pService->createCharacteristic(
                                                    CHARACTERISTIC_UUID_RX,
                                                    BLECharacteristic::PROPERTY_WRITE
                                                );

        pRxCharacteristic->setCallbacks(new MyCallbacks());

        // Start the service
        pService->start();
        // Start advertising
        pServer->getAdvertising()->start();
        Serial.println("Waiting a client connection to notify...");
    };
    void run(){
        if (!deviceConnected && oldDeviceConnected) {
            delay(500);
            pServer->startAdvertising();
            Serial.println("Start advertising...");
            oldDeviceConnected = deviceConnected;
        }
        if (deviceConnected && !oldDeviceConnected) {
            oldDeviceConnected = deviceConnected;
        }
    };
    void setConfigured(bool wifiStatus){
        BTJson.clear();
        BTJson["ok"] = wifiStatus;
        if (wifiStatus)
        {
            BTJson["message"] = "Device Configured!";
        }else{
            BTJson["message"] = "At least one fields are wrong!";
        }
        serializeJson(BTJson, deviceConfigJson);
        if (deviceConnected) {
            if (strlen(deviceConfigJson)>1)
            {
                pTxCharacteristic->setValue(deviceConfigJson);
                pTxCharacteristic->notify();
            }
            delay(10);
	    }

    }
    void stop(){
        BLEDevice::deinit(true);
    }
};
 
BTServer btserver;
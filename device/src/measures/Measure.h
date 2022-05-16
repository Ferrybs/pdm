#include <Adafruit_Sensor.h>
#include <DHT.h>
#include <DHT_U.h>
#include "core/Console.h"

DHT_Unified dht(27, DHT11);
class Measure
{
private:
    const int delayMS = 1500;
    const int luminosity = 34;
    const int moisture = 35;
    void setup();
public:
    Measure(){
        setup();
    }
    float getHumidity();
    float getTemperature();
    float getLumiosity();
    float getMoisture();
};
void Measure::setup(){
    pinMode(luminosity,INPUT);
    pinMode(moisture,INPUT);
}

float Measure::getMoisture(){
    float rawValue =analogRead(moisture);
    float value = 100 - (rawValue/4095)*100;
    console.log("Moisture: ",false);
    console.log(value,false);
    console.log("%");
    return value;
}
float Measure::getTemperature(){
    dht.begin();
     delay(delayMS);
     sensors_event_t event;
    dht.temperature().getEvent(&event);
    if (isnan(event.relative_humidity)) {
        console.log(F("Error reading Temperature!"));
        return NAN;
    }
    else {
        console.log(F("Temperature: "),false);
        console.log(String(event.relative_humidity),false);
        console.log(F("C"));
        return event.relative_humidity;
    }
}
float Measure::getLumiosity(){
    int ldrRawData = analogRead(luminosity);
    float resistorVoltage = (float)ldrRawData/4095*3.3;
    float ldrVoltage = 3.3 - resistorVoltage;
    float ldrResistance = ldrVoltage/resistorVoltage * 10000;
    float ldrLux = 12518931 * pow(ldrResistance, -1.405);
    console.log("Luminosity: ",false);
    console.log(ldrLux,false);
    console.log(" LUX");
    return ldrLux;
} 

float Measure::getHumidity(){
     dht.begin();
     delay(delayMS);
     sensors_event_t event;
    dht.humidity().getEvent(&event);
    if (isnan(event.relative_humidity)) {
        console.log(F("Error reading humidity!"));
        return NAN;
    }
    else {
        console.log(F("Humidity: "),false);
        console.log(String(event.relative_humidity),false);
        console.log(F("%"));
        return event.relative_humidity;
    }

}


Measure measure;

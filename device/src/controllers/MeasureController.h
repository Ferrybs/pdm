#include "settings/ClientSettings.h"
#include "core/Console.h"
class MeasureController
{
private:
    const int temperature  = 21;
    const int humidity  = 19;
    const int luminosity  = 18;
    const int moisture  = 22;
public:
    MeasureController(){
        setup();
    }
    void setup();
    void setHumidity(float humidity);
    void setTemperature(float temperature);
    void setLuminosity(float luminosity);
    void setMoisture(float moisture);
};
void MeasureController::setup(){
    pinMode(this->temperature,OUTPUT);
    pinMode(this->humidity,OUTPUT);
    pinMode(this->luminosity,OUTPUT);
    pinMode(this->moisture,OUTPUT);
}
void MeasureController::setTemperature(float temperature){
    if(!isnan(preferences.getTemperature())){
        Serial.println("LEITURA: "+String(temperature)+" PREFS: "+String(preferences.getTemperature()));
        if (preferences.getTemperature()< temperature)
        {
            digitalWrite(this->temperature,1);
        }else{
            digitalWrite(this->temperature,0);
        } 
    }
    
}

void MeasureController::setHumidity(float humidity){
    if(!isnan(preferences.getHumidity())){
        Serial.println("LEITURA: "+String(humidity)+" PREFS: "+String(preferences.getHumidity()));
        if (preferences.getHumidity()< humidity)
        {
            digitalWrite(this->humidity,1);
        }else{
            digitalWrite(this->humidity,0);
        } 
    }
    
}

void MeasureController::setLuminosity(float luminosity){
    if(!isnan(preferences.getLuminosity())){
        Serial.println("LEITURA: "+String(luminosity)+" PREFS: "+String(preferences.getLuminosity()));
        if (preferences.getLuminosity()< luminosity)
        {
            digitalWrite(this->luminosity,1);
        }else{
            digitalWrite(this->luminosity,0);
        } 
    }
    
}

void MeasureController::setMoisture(float moisture){
    if(!isnan(preferences.getMoisture())){
        Serial.println("LEITURA: "+String(moisture)+" PREFS: "+String(preferences.getMoisture()));
        if (preferences.getMoisture()< moisture)
        {
            digitalWrite(this->moisture,1);
        }else{
            digitalWrite(this->moisture,0);
        } 
    }
    
}

MeasureController measureController;
#include "settings/ClientSettings.h"
#include "core/Console.h"
class Controller
{
private:
    const int temperature  = 13;
public:
    Controller(){
        setup();
    }
    void setup();
    void setTemperature(float temperature);
};
void Controller::setup(){
    pinMode(this->temperature,OUTPUT);
}
void Controller::setTemperature(float temperature){
    if(!isnan(preferences.getTemperature())){
        if (preferences.getTemperature()< temperature)
        {
            digitalWrite(this->temperature,1);
        }else{
            digitalWrite(this->temperature,0);
        } 
    }
    
}

Controller controller;
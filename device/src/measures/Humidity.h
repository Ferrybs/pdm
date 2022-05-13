#include <Adafruit_Sensor.h>
#include <DHT.h>
#include <DHT_U.h>
#include "core/Console.h"

DHT_Unified dht(4, DHT11);
class Humidity
{
private:
    const int delayMS = 1500;
public:
    float getHumidity();
};

float Humidity::getHumidity(){
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

Humidity humidity;

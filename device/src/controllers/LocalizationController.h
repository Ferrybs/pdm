#include <WifiLocation.h>
WifiLocation location("AIzaSyCOncGs8U50ZT261HbqdXGdlPGoyoEyeSM");
class LocalizationController
{
private: 
    void setClock();
public:
    location_t getLocalization();
};
void LocalizationController::setClock(){
    configTime (0, 0, "pool.ntp.org", "time.nist.gov");

    Serial.print ("Waiting for NTP time sync: ");
    time_t now = time (nullptr);
    while (now < 8 * 3600 * 2) {
        delay (500);
        Serial.print (".");
        console.blink();
        now = time (nullptr);
    }
    struct tm timeinfo;
    gmtime_r (&now, &timeinfo);
    Serial.print ("\n");
    Serial.print ("Current time: ");
    Serial.print (asctime (&timeinfo));
}
location_t LocalizationController::getLocalization(){
    setClock ();
    location_t loc = location.getGeoFromWiFi();
    Serial.println("Location request data");
    Serial.println ("Location: " + String (loc.lat, 7) + "," + String (loc.lon, 7));
    return loc;
}

LocalizationController localizationController;

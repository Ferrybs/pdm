#pragma once
#include <Arduino.h>
class Console
{
private:
    const int ledPin = 2;
public:
    Console(){
        setup();
    }
    void setup();
    void log(String text="", bool ln=true);
    void log(IPAddress text, bool ln=true);
    void log(float text, bool ln=true);
    void log(int text, bool ln=true);
    void blink(int tick=2, int size=200);
    void ledOn();
    void ledOff();
};
void Console::ledOn(){
    digitalWrite(ledPin,HIGH);
}
void Console::ledOff(){
    digitalWrite(ledPin,LOW);
}
void Console::setup(){
    Serial.begin(9600);
    pinMode(ledPin,OUTPUT);
}

void Console::log(String text, bool ln){
    if (ln)
    {
        Serial.println(text);
    }else{
        Serial.print(text);
    }
    
}

void Console::log(IPAddress text, bool ln){
    if (ln)
    {
        Serial.println(text);
    }else{
        Serial.print(text);
    }
    
}

void Console::log(int text, bool ln){
    if (ln)
    {
        Serial.println(text);
    }else{
        Serial.print(text);
    }
    
}
void Console::log(float text, bool ln){
    if (ln)
    {
        Serial.println(text);
    }else{
        Serial.print(text);
    }
    
}

void Console::blink(int tick, int size){
    int count=0;
    while (count<=tick)
    {
        digitalWrite(ledPin,LOW);
        delay(rand()%size);
        digitalWrite(ledPin,HIGH);
        delay(rand()%size);
        count++;
    }
    digitalWrite(ledPin,HIGH);
}
Console console;


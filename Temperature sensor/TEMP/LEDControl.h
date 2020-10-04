/*
Dyrektywy zapobiegające dołączeniu tego samego pliku
więcej niż jeden raz do projektu
*/
#ifndef LEDCONTROL_H_   
#define LEDCONTROL_H_

#include <m8c.h> //Bilbioteka umozliwiajaca wykorzystanie typu BOOL        

//Deklaracja zmiennych 
extern int LEDControl_RT;
extern int LEDControl_BT;
extern int LEDControl_GT;

//Deklaracja funkcji
void LEDControl_INIT(void);
void LEDControl_ChangeState(BOOL,BOOL,BOOL);
BYTE LEDControl_ChangeStateSwitch(BYTE led ,BOOL isASC);
void LEDControl_ChangeFrequency(BYTE,int,BYTE);
int LEDControl_Blink(BYTE, int);

#endif 
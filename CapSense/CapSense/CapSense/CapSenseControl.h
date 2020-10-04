/*
Dyrektywy zapobiegające dołączeniu tego samego pliku
więcej niż jeden raz do projektu
*/
#ifndef CAPSENSECONTROL_H_   
#define CAPSENSECONTROL_H_

// Biblioteka zawierająca typy danych, stale etc.
#include <m8c.h>        

// Deklaracja struktury danych
typedef struct CapSenseControl_DataStruct {
	BYTE led;
	BYTE sliderPos;
} CapSenseControl_DataStruct;

// Deklaracja struktury danych
typedef struct CapSenseControl_ScanStruct{
	BYTE action;
	BYTE value;
} CapSenseControl_ScanStruct;

// Deklaracja zmiennej typu DataStruct
extern CapSenseControl_DataStruct CapSenseControl_Data;

//Deklaracja funkcji
void CapSenseControl_INIT(void);
CapSenseControl_ScanStruct CapSenseControl_DoScan(void);

#endif 
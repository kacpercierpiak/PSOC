#ifndef CAPSENSECONTROL_H_   
#define CAPSENSECONTROL_H_

#include <m8c.h>        

typedef struct CapSenseControl_DataRegsStruct {
	BYTE led;
BYTE sliderPos;
}CapSenseControl_DataRegsStruct;

typedef struct CapSenseControl_ScanReturnStruct{
BYTE action;
BYTE value;
}CapSenseControl_ScanReturnStruct;

extern CapSenseControl_ScanReturnStruct CapSenseControl_ScanReturn;
extern CapSenseControl_DataRegsStruct CapSenseControl_DataRegs;

void CapSenseControl_INIT(void);
CapSenseControl_ScanReturnStruct CapSenseControl_Scan(void);



#endif 
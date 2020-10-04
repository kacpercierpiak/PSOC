#include "CapSenseControl.h"
#include <m8c.h>        
#include "PSoCAPI.h"    
#include <stdlib.h>
#define Interval 50
#define POS 		1
#define RWBOUNDARY	2
CapSenseControl_DataRegsStruct CapSenseControl_DataRegs;
CapSenseControl_ScanReturnStruct CapSenseControl_ScanReturn;
BOOL CapSensPush;
int fingerposition;
int loopQty; 

void CapSenseControl_INIT(void)
{
	EzI2Cs_SetRamBuffer(sizeof(CapSenseControl_DataRegs), RWBOUNDARY, (BYTE *) &CapSenseControl_DataRegs);
    CSD_Start();   
	CSD_ScanAllSensors();   
	CSD_InitializeBaselines();   
	CSD_SetDefaultFingerThresholds();
	EzI2Cs_Start();
	CapSenseControl_DataRegs.led = 3;
	CapSenseControl_ScanReturn.action=0;
	CapSenseControl_ScanReturn.value=0;
	CapSensPush=FALSE;
	loopQty=0;
	fingerposition=0;
}


void CapSenseControl_GetNewBlinkFreq(void)
{
	
	fingerposition = CSD_wGetCentroidPos(POS); 
	if (!CapSensPush && CapSenseControl_DataRegs.sliderPos==0)
	{
		CapSenseControl_DataRegs.sliderPos = (BYTE) fingerposition;
		CapSensPush = TRUE;
	}
			
	if ( abs(CapSenseControl_DataRegs.sliderPos-fingerposition) >=10)
	{
		if (CapSenseControl_DataRegs.sliderPos-fingerposition>0 )
		{					
			CapSenseControl_ScanReturn.action = 1;
			CapSenseControl_ScanReturn.value = abs(CapSenseControl_DataRegs.sliderPos-fingerposition)/Interval;								
		}
		if (CapSenseControl_DataRegs.sliderPos-fingerposition<0 )
		{
			CapSenseControl_ScanReturn.action = 2;
			CapSenseControl_ScanReturn.value = abs(CapSenseControl_DataRegs.sliderPos-fingerposition)/Interval;
		}
				CapSensPush = FALSE;
	}	
}

void CapSenseControl_ChangeActiveLED(void)
{
	loopQty++;
	if (loopQty>=10)
	{			
		if (CapSensPush)
		{
			if(fingerposition < 50 && fingerposition >=0)
			{
				CapSenseControl_ScanReturn.action = 3;
				CapSenseControl_ScanReturn.value = CapSenseControl_DataRegs.led;						
			}
			else
			{
			CapSenseControl_ScanReturn.action = 4;
			CapSenseControl_ScanReturn.value = CapSenseControl_DataRegs.led;						
			}
		}																
		loopQty=0;
		CapSensPush = FALSE;
		CapSenseControl_DataRegs.sliderPos = 0;
	}
}

	

struct CapSenseControl_ScanReturnStruct CapSenseControl_Scan(void)
{	
	CapSenseControl_ScanReturn.action=0;
	CapSenseControl_ScanReturn.value=0;
	CSD_ScanAllSensors(); 
	CSD_UpdateAllBaselines();
	
	if(CSD_bIsAnySensorActive())
		{
			CapSenseControl_GetNewBlinkFreq();			
		}
		else
		{
			CapSenseControl_ChangeActiveLED();
		}
		return CapSenseControl_ScanReturn;
}
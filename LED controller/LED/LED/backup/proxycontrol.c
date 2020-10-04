#include "ProxyControl.h"
#include <m8c.h>        
#include "PSoCAPI.h"    
#include <stdlib.h>

void ProxyControl_INIT(void)
{
    CSD_Start();   
	CSD_ScanAllSensors();   
	CSD_InitializeBaselines();   
	CSD_SetDefaultFingerThresholds();
}
BYTE CapSenseControl_Proxy(void)
{
		CSD_ScanAllSensors(); /* scan all sensors in array (buttons and sliders) */
		CSD_UpdateAllBaselines();
		return CSD_bIsAnySensorActive();
}
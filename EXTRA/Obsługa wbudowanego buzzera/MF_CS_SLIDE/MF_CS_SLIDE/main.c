
#include <m8c.h>        /* part specific constants and macros */
#include "PSoCAPI.h"    /* PSoC API definitions for all User Modules */
#define POS 		1
#define BUFSIZE		1
#define RWBOUNDARY	2
#define BLUE	1
#define GREEN	2
#define RED		3
#define NO_FINGER	0xFF

struct I2C_Regs 
{ 
BYTE led;
BYTE sliderPos;
} Data_Regs;

void main(void)
{
	 int fingerposition;
	 EzI2Cs_SetRamBuffer(sizeof(Data_Regs), RWBOUNDARY, (BYTE *) &Data_Regs);   /* Setting RAM Buffer */
	 M8C_EnableGInt ;   /* Enabling the Global Interrupts */

	CSD_Start();   /*Start CSD Module */
	CSD_ScanAllSensors();   /* Scan all the available sensors */
	CSD_InitializeBaselines() ;   /* Initialise base line for the sensors */
	CSD_SetDefaultFingerThresholds();
	LED_BLUE_Start();
	LED_GREEN_Start();
	LED_RED_Start();
	EzI2Cs_Start();   /* Turn on I2C */
	PWM8_1_Start();
	while(1) /*Infinite loop */
	{
		CSD_ScanAllSensors();  /*Scan all sensors in array (buttons and sliders) */
		CSD_UpdateAllBaselines();
		LED_RED_Off();
		LED_GREEN_Off();
		LED_BLUE_Off();
		
		LED_B

		if(CSD_bIsAnySensorActive())  /* is any sensor active */
		{
			fingerposition = CSD_wGetCentroidPos(POS);  /*Get the centroid position for the system	*/
			PWM8_1_WritePeriod((BYTE)fingerposition/2);
			PWM8_1_WritePulseWidth((BYTE)fingerposition/4);
			if(fingerposition < 33 && fingerposition >0) /*If the value returned from Centroid position is 
			                               greater than 0 and less than or equal to 33 */
			{			
				Data_Regs.led = BLUE;
				LED_BLUE_On();
			}
			else if(fingerposition < 66 && fingerposition >=33)  /*If the value returned from Centroid position is 
			                                      greater than 33 and less than or equal to 66 */

			{
				
				Data_Regs.led = GREEN;

				LED_GREEN_On();
			}
			else if(fingerposition < 99 && fingerposition >=66)  /*If the value returned from Centroid position is
			                                      greater than 66 and less than or equal to 99 */
			{
				
				Data_Regs.led = RED;
				LED_RED_On();
			}
			Data_Regs.sliderPos = (BYTE) fingerposition;			
		}
		else
		{
			
			Data_Regs.sliderPos = 0;
			Data_Regs.led = 0;			
		}
	}
}

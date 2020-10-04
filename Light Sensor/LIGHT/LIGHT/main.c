#include <m8c.h> // Biblioteka zawierająca typy danych, stale etc.        
#include "PSoCAPI.h" // Biblioteka zawierająca funkcje PSoC    
#include "LEDControl.h" // Biblioteka diod LED
#include "lightcontrol.h" // Biblioteka czujnika światla

//Struktura do przesylania danych miedzy FRMF a FTRF 
struct I2C_Regs 
{ 
BYTE led;
BYTE light;
} Data_Regs;

void main(void)
{
  //Rezerwowanie Buforu pamieci do komunikacji I2C
  EzI2Cs_SetRamBuffer(sizeof(Data_Regs), 2, (BYTE *) &Data_Regs);
  //Inicjalizacja przerwań globalnych, 
  //konieczne dla ADC
  M8C_EnableGInt; 
  //Inicjalizacja bilbioteki do
  //obslugi diod led
  LEDControl_INIT();
  //Inicjalizacja bilbioteki do
  //obslugi czujnika swiatla
  LightControl_INIT();
  //Uruchomienie komunikacji I2C		
  EzI2Cs_Start();
	
  while(1)        
  {
	//Pobranie wartosci natezenie swiatla 0-100
    int result = LightControl_Scan();
	Data_Regs.light = result;
	Data_Regs.led = result>0x00 ? 1 : 0;
	//Jesli natezenie > 40 wlacz wszystkie diody
    //Jesli natezenie > 25 wlacz diode czerwona i zielona
	//W przeciwnym wypadku wlacz diode czerwona
	result > 40 ? LEDControl_ChangeState(TRUE,TRUE,TRUE) : 
	result > 25 ? LEDControl_ChangeState(TRUE,TRUE,FALSE) : 
	LEDControl_ChangeState(TRUE,FALSE,FALSE);   
  }
}

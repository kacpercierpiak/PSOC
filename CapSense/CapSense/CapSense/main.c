// Biblioteka zawierająca typy danych, stale etc.
#include <m8c.h>    
// Biblioteka zaweriajace funkcje dla peryferiów    
#include "PSoCAPI.h"  
// Biblioteka do obsługi diod LED
#include "LEDControl.h"
// Biblioteka do obsługi paska CapSense
#include "CapSenseControl.h"

void main(void)
{	
  //Deklaracja oraz inicjalizacja
  //licznika petli
  int blinkLoop=0;
	
  // Inicjalizacja przerwań globalnych, 
  // konieczne dla ADC
  M8C_EnableGInt ; 
	
  // Inicjalizacja biblioteki do
  // obsługi diod Led
  LEDControl_INIT();
	
  // Inicjalizacja biblioteki do
  // obsługi czujnika zbliżeniowego	
  CapSenseControl_INIT();
  while(1)
  {	
	// Deklaracja zmiennej
    CapSenseControl_ScanStruct CSC_SRS;
    // Inkrementacja licznika petli
    blinkLoop++;
	
	// Zmiana stanu aktywnej diody jeśli 
	// Wymagana liczba cykli zostala osiagnieta
	// Jeśli tak to zmienna blinkLoop jest zerowana
    blinkLoop=LEDControl_Blink(CapSenseControl_Data.led,blinkLoop);
	
	// Sprawdzenie czy oraz jaki gest zostal wykonany na suwaku	
    CSC_SRS = CapSenseControl_DoScan();
	
	/* Interpretacja gestu w zaleznosci od wyniku
	1 - Ruch w prawo, zmniejszenie czestotliwosc migania
	2 - Ruch w lewo, zwiekszenie czestotliwosc migania
	3 - Klikniecie lewj czesci, poprzednia dioda
	4 - Klikniecie lewj czesci, nastepna dioda
	*/ 
    switch (CSC_SRS.action)
    {
      case 1:
        LEDControl_ChangeFrequency(CapSenseControl_Data.led,CSC_SRS.value,FALSE);	
        break;
      case 2:
        LEDControl_ChangeFrequency(CapSenseControl_Data.led,CSC_SRS.value,TRUE);
        break;
      case 3:		
        CapSenseControl_Data.led = LEDControl_ChangeStateSwitch(CSC_SRS.value,TRUE);
        break;
      case 4:		
        CapSenseControl_Data.led = LEDControl_ChangeStateSwitch(CSC_SRS.value,FALSE);
        break;
      default:
        break; 
    }	
  }
}

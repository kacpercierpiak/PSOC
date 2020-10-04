#include <m8c.h> // Biblioteka zawierająca typy danych, stale etc.
#include "PSoCAPI.h" // Biblioteka zawierające funkcje PSoC
#include "LEDControl.h" // Biblioteka do obsługi diod LED
#include "TempControl.h" // Bilioteka obslugujaca termistor

void main(void)
{
  //Inicjalizacja przerwań globalnych, 
  //konieczne dla ADC
  M8C_EnableGInt; 
  
  //Inicjalizacja biblioteki do
  //obsługi diod Led
  LEDControl_INIT();
  TempControl_Init();
  
  while(1)
  {	
	/*
	TempControl_GetValue() - zwraca grupe odczytaniej temperatury
	0 - Blad pomiaru, wylaczenie wszystkich diod
	1 - Niskie, wlaczona dioda niebieska
	2 - Umiarkowane, wlaczona dioda zielona
	3 - Wysokie, wlaczona dioda czerwona
	*/
    switch(TempControl_GetValue())
    {
      case 0:
        LEDControl_ChangeState(FALSE,FALSE,FALSE); 
        break;
      case 1:
        LEDControl_ChangeState(FALSE,FALSE,TRUE); 
        break;
      case 2:
        LEDControl_ChangeState(FALSE,TRUE,FALSE);
        break;
      case 3:
        LEDControl_ChangeState(TRUE,FALSE,FALSE);
        break;
      default: 
        break;
    }	
  }
}


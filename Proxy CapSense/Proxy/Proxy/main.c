#include <m8c.h> // Biblioteka zawierająca typy danych, stałe etc.        
#include "PSoCAPI.h" // Biblioteka zawierające funkcje PSoC    
#include "LEDControl.h" // Biblioteka do obsługi diod LED
#include "ProxyControl.h" // Biblioteka obsługujaca czujni zbliżeniowy

void main(void)
{	
  int blinkLoop=0;
  // Inicjalizacja przerwań globalnych, 
  // konieczne dla ADC
  M8C_EnableGInt ; 
	
  // Inicjalizacja biblioteki do
  // obsługi diod Led
  LEDControl_INIT();
	
  // Inicjalizacja biblioteki do
  // obsługi diod czujnika zbliżeniowego	
  ProxyControl_INIT();
	
  while(1) 
  {	
	// Jeśli wykryto obiekt wlaczona dioda niebieskie 
	// w przeciwnym wypadku czerwona 
	ProxyControl_Proxy()? LEDControl_ChangeStateSwitch(2,TRUE): 
	LEDControl_ChangeStateSwitch(1,TRUE);
  }
}

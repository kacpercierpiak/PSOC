#include <m8c.h> // Biblioteka zawierająca typy danych, stale etc.        
#include "PSoCAPI.h"    // Biblioteka zaweriajace funkcje dla peryferiów
#include "LEDControl.h" //Biblioteka do obslugi diod LED

void main(void)
{
  //Deklaracja i inicjalizacja liczników petli
  //Kazda dioda posiada niezalezny	 
int blinkLoopR=0;	 
  int blinkLoopG=0;	
  int blinkLoopB=0;		
	
  //Inicjalizacja biblioteki LED
  LEDControl_INIT();
	
  //Inicjalizacja ilosci cykli 
  //do zmiany stanu dla kazdej diody	
  LEDControl_RT = 500;
  LEDControl_GT = 1000;
  LEDControl_BT = 1500;
	
  //Glowna petla programy, 1 = TRUE
  //Jest to petla nieskonczona	
  while(1)
  {	
	//Inkrementacja licznikow
    blinkLoopR++;
	blinkLoopG++;
	blinkLoopB++;
	//Uruchomienie funkcji z biblioteki LEDControl
    blinkLoopR=LEDControl_Blink(3,blinkLoopR);    
    blinkLoopG=LEDControl_Blink(2,blinkLoopG);   
    blinkLoopB=LEDControl_Blink(1,blinkLoopB);
  }
}

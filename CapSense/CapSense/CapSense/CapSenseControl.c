// Dodanie naglowka bilbioteki
#include "CapSenseControl.h"

// Biblioteka zawierająca typy danych, stale etc.
#include <m8c.h>   
// Biblioteka zaweriajace funkcje dla peryferiów    
#include "PSoCAPI.h"   
// Biblioteka udostepniajaca funkcje abs()
#include <stdlib.h>

// Deklaracja dzielnika
#define Ratio 50


CapSenseControl_DataStruct CapSenseControl_Data;
CapSenseControl_ScanStruct CapSenseControl_Scan;

// Zmienna dzieki ktorej mozliwe jest rozróżnienie
// Nacisniecia i gestu na suwaku
BOOL CapSensPush;
int fingerposition;
int loopQty; 

/// <summary>
/// Funkcja inicjalizująca suwak CapSense
/// </summary>
/// <remarks> 
/// <para> CSD_Start() - inicjalizuje moduł CSD</para>
/// <para>CSD_InitializeBaselines() - Załadowanie tablicy 
/// czujników CapSense</para>
/// <para>CSD_SetDefaultFingerThresholds() - aktywacja kalibracji 
/// modulu</para>
/// </remarks>

void CapSenseControl_INIT(void)
{
    CSD_Start();   
	CSD_ScanAllSensors();   
	CSD_InitializeBaselines();   
	CSD_SetDefaultFingerThresholds();
	CapSenseControl_Data.led = 3;
	CapSenseControl_Scan.action=0;
	CapSenseControl_Scan.value=0;
	CapSensPush=FALSE;
	loopQty=0;
	fingerposition=0;
}


/// <summary>
/// Funkcja ustawia nowa wartosc czestotliwosci migania diody
/// </summary>
/// <remarks> 
/// <para> CSD_Start() - inicjalizuje moduł CSD</para>
/// <para>CSD_InitializeBaselines() - Załadowanie tablicy 
/// czujników CapSense</para>
/// <para>CSD_SetDefaultFingerThresholds() - aktywacja kalibracji 
/// modulu</para>
/// </remarks>
void CapSenseControl_GetNewBlinkFreq(void)
{
	// Pobranie pozycji palca 1 tryb pracy - suwak
	fingerposition = CSD_wGetCentroidPos(1); 
	
	// Wyzerowanie pozycji palca oraz ustawienie trybu push
	if (!CapSensPush && CapSenseControl_Data.sliderPos==0)
	{
		CapSenseControl_Data.sliderPos = (BYTE) fingerposition;
		CapSensPush = TRUE;
	}
	
	// Jeśli różnica miedzy aktualny pomiarem a poprzednim wieksza niz 10
	// Wykrycie wykonania gestu
	if ( abs(CapSenseControl_Data.sliderPos-fingerposition) >=10)
	{
		// Gest w prawo 1 w lewo 2
		// Ustawienie trybu na gest
		CapSenseControl_Scan.action = CapSenseControl_Data.sliderPos-fingerposition>0 ? 1 : 2;
		CapSenseControl_Scan.value = abs(CapSenseControl_Data.sliderPos-fingerposition)/Ratio;
		CapSensPush = FALSE;
	}	
}

/// <summary>
/// Funkcja determinuje czy po nacisnieciu ma zostac wlaczona
/// nastepna czy poprzednia dioda.
/// </summary>
/// <remarks> 
/// <para> loopQty - Zabezpieczenie, przez 10 wywolan funkcji
/// nalezy trzymac palec w tej samej pozycji na suwaku</para>
/// </remarks>
void CapSenseControl_ChangeActiveLED(void)
{
	loopQty++;
	if (loopQty>=10)
	{			
		if (CapSensPush)
		{
			if(fingerposition < 50 && fingerposition >=0)
			{
				CapSenseControl_Scan.action = 3;
				CapSenseControl_Scan.value = CapSenseControl_Data.led;						
			}
			else
			{
			CapSenseControl_Scan.action = 4;
			CapSenseControl_Scan.value = CapSenseControl_Data.led;						
			}
		}																
		loopQty=0;
		CapSensPush = FALSE;
		CapSenseControl_Data.sliderPos = 0;
	}
}

/// <summary>
/// Glowna funkcja skanujaca suwak
/// </summary>
CapSenseControl_ScanStruct CapSenseControl_DoScan(void)
{	
	CapSenseControl_Scan.action=0;
	CapSenseControl_Scan.value=0;
	CSD_ScanAllSensors(); 
	CSD_UpdateAllBaselines();
	
	CSD_bIsAnySensorActive() ? CapSenseControl_GetNewBlinkFreq() : CapSenseControl_ChangeActiveLED();
	return CapSenseControl_Scan;
}
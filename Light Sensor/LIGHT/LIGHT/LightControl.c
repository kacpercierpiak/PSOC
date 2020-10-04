#include <m8c.h> // Biblioteka zawierająca typy danych, stale etc.         
#include "PSoCAPI.h" // Biblioteka zawierająca funkcje PSoC    
#include "LightControl.h" // Dodanie naglowka bilbioteki
//Deklaracja i zdefiniowanie stalej rozdzielczosci ADC
//Uzywany jest przetwornik 10 bitowy stąd liczba 10
#define ADC_RESOLUTION 10

/// <summary>
/// Funkcja inicjalizująca czujnik światla
/// </summary>
/// <remarks> 
/// <para>ADC10_Start() - inicjalizuje modul z parametrem 
/// <c>ADC10_FULLRANGE</c> oznaczający niestandardowy zakres </para>
/// <para>ADC10_iCal() - Kalibracja przetwrnika ADC 0x01FF = 1.3V
/// sygnal kalibrujacy pochodzi z VBG</para>
/// <para>ADC10_StartADC() - uruchomienie ciągle odczytu</para>
/// </remarks>
void LightControl_INIT(void)
{
  ADC10_Start(ADC10_FULLRANGE);
  ADC10_iCal(0x1FF, ADC10_CAL_VBG);   	
  ADC10_StartADC(); 
}

/// <summary>
/// Funkcja odczytujaca wartosc z czujnika swiatla
/// </summary>
int LightControl_Scan( void )
{
  //Deklaracja zmiennych tymczasowych
  long readValue;
  long v1;
  int result = 0;
  /*Sprawdzenie dostepnosci danych */
  while(ADC10_fIsDataAvailable() == 0){};  
  {
    /* Pobranie danych */
    readValue = ADC10_iGetData(); 			
    v1 = (long) readValue * 101;
    /* Przesunniecie bitowe 1 w lewo o 10 */
    v1 = v1 / (1 << ADC_RESOLUTION);
    /* Upewnienie sie ze maksymalna liczba to 100 */
    if (v1 > 100)  v1 = 100;  
      result = (int) v1;					
  }
  //Zwrocenie wartosci
  return result;
}
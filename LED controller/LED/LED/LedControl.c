#include "LEDControl.h" // Dodanie naglowka
#include <m8c.h>        // Biblioteka zawierająca typy danych, stale etc.
#include "PSoCAPI.h"    // Biblioteka zaweriajace funkcje dla peryferiów

//Definiowanie stalej dla maksymalnej wartosci interwalu
#define IntervalLimit 80

//Definiowanie stalych dla kolorow diod, implementacja enum w C
#define BLUE   1
#define GREEN  2
#define RED    3

//Inicjalizacja wartosci czestotliwosci migania diod
LEDControl_RT = 50;
LEDControl_BT = 50;
LEDControl_GT = 50;

/// <summary>
/// Funkcja inicjalizująca diody
/// </summary>
/// <remarks> 
/// <para>[nazwa modulu]_Start() - w praktyce to samo dzialanie co _Stop, inicjalizuje modul oraz 
/// wylacza wybrana diode niezależnie od stanu ustawionego w module</para>
/// <para>LED_RED_On() - wlacza diode czerwona</para>
/// </remarks>
void LEDControl_INIT(void)
{
  LED_BLUE_Start(); 
  LED_GREEN_Start();
  LED_RED_Start();
  LED_RED_On();
}

/// <summary>
/// Funkcja służy do bezpośredniego sterowania diodami.
/// </summary>
/// <remarks>
/// <para>Funkcja przyjmuje 3 paramatry TRUE/FALSE. TRUE wlacza dioda, FALSE wylacza</para>
/// <para>[nazwa modulu]_On() wlaczenie diody</para>
/// <para>[nazwa modulu]_Off() wylaczenie diody</para>
/// </remarks>
/// <param name="red">Dioda czerwona</param>
/// <param name="green">Dioda zielona</param>
/// <param name="blue">Dioda niebieska</param>

void LEDControl_ChangeState(BOOL red,BOOL green,BOOL blue)
{
	red ? LED_RED_On() : LED_RED_Off();
	green ? LED_GREEN_On() : LED_GREEN_Off();
	blue ? LED_BLUE_On() : LED_BLUE_Off();
}

/// <summary>
/// Funkcja zmienia aktualnie swiecaca diode oraz zwraca jej numer
/// </summary>
/// <returns>
/// Zwraca wartość 0,1,2 lub 3, zgodna z ENUM[BLUE,GREEN,RED] oraz wykorzystuje funkcje <c>LEDControl_ChangeState()</c>
/// </returns>
/// <param name="led">Zmienna do której przekazujemy aktualnie aktywną diode ENUM[BLUE,GREEN,RED]</param>
/// <param name="isASC">Jesli isASC: TRUE - kolejność od lewej do prawej, False - kolejność od prawej do lewej</param>
BYTE LEDControl_ChangeStateSwitch(BYTE led ,BOOL isASC)
{
  switch (led)
  {
    case 0:
      isASC ? LEDControl_ChangeState(TRUE,FALSE,FALSE) : LEDControl_ChangeState(FALSE,FALSE,TRUE);
	  return isASC ? RED : BLUE;
      break;
    case GREEN:
	  isASC ? LEDControl_ChangeState(FALSE,FALSE,TRUE) : LEDControl_ChangeState(TRUE,FALSE,FALSE);
      return isASC ? BLUE : RED;      
      break;
    case BLUE:
	  isASC ? LEDControl_ChangeState(TRUE,FALSE,FALSE) : LEDControl_ChangeState(FALSE,TRUE,FALSE);
      return isASC ? RED : GREEN;		
      break;
    case RED:
	  isASC ? LEDControl_ChangeState(FALSE,TRUE,FALSE) : LEDControl_ChangeState(FALSE,FALSE,TRUE);
      return isASC ? GREEN : BLUE;
      break;
    default:
      return 0;
      break;
  }      
}

/// <summary>
/// Funkcja waliduje wartosc czestotliwosci migania diody
/// </summary>
/// <remarks>
/// <para>Funkcja dodaje liczbe addValue która może być ujemna do wartosci podanej w pierwszym parametrze</para>
/// </remarks>
/// <returns>
/// <para>Jeśli wartość jest mniejsza od 0 to zwraca zero w przeciwnym wypadku</para>
/// <para>Jeśli wartość jest wieksza od stalej <c>IntervalLimit</c> to zwraca wartosc <c>IntervalLimit</c></para>
/// <para>W przeciwnym wypadku zwraca obliczona wartosc</para>
/// </returns>
/// <param name="sourceValue">Wartosc modyfikowana</param>
/// <param name="addValue">Wartosc o ktora bedzie modyfikowana wartosc zrodlowa</param>
int LEDControl_ValueValidation(int sourceValue, int addValue)
{
  sourceValue += addValue;
  sourceValue = sourceValue < 0 ? 0 : sourceValue > IntervalLimit ? IntervalLimit : sourceValue;
  return sourceValue;
}

/// <summary>
/// Funkcja zmienia wartosc czestotliwosc migania diody
/// </summary>
/// <remarks>
/// <para>Funkcja dodaje liczbe addValue która może być ujemna do wartosci podanej w pierwszym parametrze</para>
/// </remarks>
/// <param name="led">Wartość 0,1,2 lub 3, zgodna z ENUM[BLUE,GREEN,RED] do zmiany czestotliwosci</param>
/// <param name="value">Wartosc zmiany czestotliwosci</param>
/// <param name="isAdd">Zmienna Bool determinuje zwiekszanie lub zmniejszanie czestotliowosci</param>
void LEDControl_ChangeFrequency(BYTE led,int value,BYTE isAdd)
{
  value = isAdd ? value : value * -1;	
  switch (led)
  {
    case RED:
      LEDControl_RT = LEDControl_ValueValidation(LEDControl_RT, value);
      break;
    case BLUE:
	  LEDControl_BT = LEDControl_ValueValidation(LEDControl_BT, value);
      break;
    case GREEN:
	  LEDControl_GT = LEDControl_ValueValidation(LEDControl_GT, value);
      break;
    default:
      break; 
  }
}

/// <summary>
/// Funkcja zmieniajaca stan diod w zaleznosci od licznika cykli petli
/// </summary>
/// <remarks>
/// <para>Funkcja powinna byc umieszczona w petli, a jej licznik powinien byc przekazany jako parametr</para>
/// <para>Gdy limit cykli LEDControl_RT,LEDControl_GT,LEDControl_BT zostanie osiagniety nastepuje zmiana stanu diody</para>
/// <para>Rownoczesnie nastepuje wyzerowanie licznika petli i zwrocenie jego wartosci</para>
/// </remarks>
/// <param name="led">Wartość 0,1,2 lub 3, zgodna z ENUM[BLUE,GREEN,RED]</param>
/// <param name="blinkLoop">Licznik petli</param>
int LEDControl_Blink(BYTE led, int blinkLoop)
{
  switch (led)
  {
    case RED:
      if (blinkLoop>=LEDControl_RT)
        {
          LED_RED_Invert();
          blinkLoop = 0;
        }
        return blinkLoop;
        break;
    case BLUE:
      if (blinkLoop>=LEDControl_BT)
      {
        LED_BLUE_Invert();
        blinkLoop = 0;
      }
      return blinkLoop;
      break;
    case GREEN:
      if (blinkLoop>=LEDControl_GT)
      {
        LED_GREEN_Invert();
        blinkLoop = 0;
      }
      return blinkLoop;
      break;
    default:
      return blinkLoop;
      break; 
  }
}
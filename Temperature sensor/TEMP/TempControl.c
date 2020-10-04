#include <m8c.h> // Biblioteka zawierająca typy danych, stale etc.
#include "PSoCAPI.h" // Biblioteka zawierające funkcje PSoC
#include "TempControl.h" //Dodanie naglowka biblioteki

//Stale minimalna i maksymalna temperatura (-10.1 C oraz 55.1 C)
#define	MIN		-101
#define	MAX		551	
//Stala ilosci progow temperatury w tablicy arTherm
#define COUNT_VALUES    23
//Stala rezystora referencyjnego
#define REF_RESISTOR	10000
//Makra odczytujace temperature
#define ReadVTEMPInput      (ABF_CR0 = 0x00)
#define ReadVTEMP_EXCInput  (ABF_CR0 = 0x80)

//Tablica dwuwymiarowa z kalibracja temperatur
const int arTherm[2][COUNT_VALUES] = 
{   
   {2301, 2505, 2725, 2960, 3211, 3477, 3757, 4051, 4358, 4675, 5000, 5331, 5664, 5998, 6328, 6652, 6967, 7269, 7557, 7829, 8083, 8317,  8462},
   {5500, 5200, 4900, 4600, 4300, 4000, 3700, 3400, 3100, 2800, 2500, 2200, 1900, 1600, 1300, 1000,  700,  400,  100, -200, -500, -800, -1000}  
//     1           3           5           7           9          11          13          15          17          19          21           23
};
//Definicja nowego typu danych dla odczytu temperatury
typedef struct ThermistorValue
{
	long lVtherm;
	long ivalue1;
}ThermistorValue;

/// <summary>
/// Funkcja przeksztalca wartosc napiecia termistora na temperature w C
/// </summary>
/// <remarks>
/// <para>Funkcja uwzglednienie rezystancji referencyjna oraz odczyt z adresu 0x80</para>
/// </remarks>
/// <returns>
/// <para>Funkcja zwraca liczbe calkowita z przedziala od -10C do 55C</para>
/// </returns>
/// <param name="thermistorValue">Struktura przechowujaca odczyt z termistora</param>
int CalculateTemperature(ThermistorValue thermistorValue)
{
	BYTE bPointIndex;
	long ivalue1,ivalue2,itemp1,itemp2;
	
	//Uwzglednienie rezystancji referencyjnej
	thermistorValue.lVtherm *= REF_RESISTOR;	
	thermistorValue.lVtherm /= thermistorValue.ivalue1;			

	if ((int)thermistorValue.lVtherm < arTherm[0][0])
	{          
		thermistorValue.lVtherm = MAX;
	}
	else if((int)thermistorValue.lVtherm > arTherm[0][COUNT_VALUES-1])
	{
		thermistorValue.lVtherm = MIN; 
	}
	else 
	{  
               
		for(bPointIndex = 0; bPointIndex < (COUNT_VALUES-2); bPointIndex++) 
		{																			
			if (thermistorValue.lVtherm < arTherm[0][bPointIndex+1])  break;
		}
	
		ivalue1 = arTherm[0][bPointIndex];
		ivalue2 = arTherm[0][bPointIndex + 1];

		itemp1 = arTherm[1][bPointIndex];
		itemp2 = arTherm[1][bPointIndex + 1];

		thermistorValue.lVtherm = (((long) ivalue2 - thermistorValue.lVtherm) * (itemp1 - itemp2)) / (ivalue2 - ivalue1) + itemp2;

        ivalue1 = thermistorValue.lVtherm;
     
        if (ivalue1 < 0)
        {               
            bPointIndex = 1; 
            ivalue1 = 0 - ivalue1;
        }
        else
        {
            bPointIndex = 0;
        }

        ivalue2 = ivalue1 / 10;  

        if ((ivalue2 * 10 + 5) <= ivalue1)
        {
            ivalue2++;
        }
                          
        if (bPointIndex)
        {
            ivalue2 = 0 - ivalue2;
        }
  
        thermistorValue.lVtherm = ivalue2;
	}
		return thermistorValue.lVtherm;
}
/// <summary>
/// Funkcja inicjalizująca termistor
/// </summary>
/// <remarks> 
/// <para>ADC10_Start() - inicjalizuje moduł z parametrem 
/// <c>ADC10_FULLRANGE</c> oznaczający niestandardowy zakres /// </para>
/// <para>ADC10_iCal() - Kalibracja przetwornika ADC 0x01FF = 1.3V
/// sygnał kalibrujący pochodzi z VBG</para>
/// <para>ADC10_StartADC() - uruchomienie ciągle odczytu</para>
/// </remarks>

void TempControl_Init(void)
{
	ADC10_Start(ADC10_FULLRANGE); 
	ADC10_iCal(0x1FF, ADC10_CAL_VBG);  
	ADC10_StartADC();	
}

/// <summary>
/// Funkcja odczytujaca wartosc napiecia na termistorze
/// </summary>
/// <returns>
/// <para>Funkcja zwraca zmienna typu ThermistorValue</para>
/// <para>W sklad struktury wchodzi odczyt z adresow 0x00 oraz 0x80 </para>
/// </returns>
ThermistorValue GetValueFromThermistor(void)
{
	int i;
	TempControl_Init();
	
	//Zmiana odczytywanego adresu
	ReadVTEMPInput;  
	
	//Odczyt wartosc z termistora
	while(ADC10_fIsDataAvailable() == 0){}; 
	thermistorValue.lVtherm = ADC10_iGetDataClearFlag(); 
	
	//Zmiana odczytywanego adresu	
    ReadVTEMP_EXCInput; 

	//Odczyt wartosc z termistora po uplywie 2000 cykli procesora
	for(i=0; i<20000; i++){;}
	while(ADC10_fIsDataAvailable() == 0){};
	thermistorValue.ivalue1 = ADC10_iGetDataClearFlag();
		
	ADC10_Stop();
	ADC10_StopADC();
	return thermistorValue;
}

/// <summary>
/// Funkcja odczytujaca temperature termistora
/// </summary>
/// <returns>
/// <para>Funkcja zwraca wartosc calkowita</para>
/// </returns>
int GetTemperature(void)
{
	ThermistorValue thermistorValue;
	thermistorValue = GetValueFromThermistor();
	return CalculateTemperature(thermistorValue);
}

/// <summary>
/// Funkcja pokazujaca poziom temperatury
/// </summary>
/// <remarks>
/// <para>Funkcja laczy temperatury w grupy 1-niskie, 
/// 2-umiarkowane, 3-wysokie, 0 - oznacza blad pomiaru
/// </para>
/// </remarks>
/// <returns>
/// <para>Dla temperatur -10C oraz 24 zwraca 1</para>
/// <para>Dla temperatur 24 do 28 zwraca 2</para>
/// <para>Dla temperatur 28 do 55 zwraca 3</para>
/// <para>Dla pozostalych zwraca 0</para>
/// </returns>
int TempControl_GetValue(void)
{
	int lVtherm;
	lVtherm = GetTemperature();	
	if ((lVtherm >= -100) && (lVtherm < 240)) // TRUE if temp is between -10 and 24
	{
		return 1;
	}
	else if ((lVtherm >= 240) && (lVtherm < 280)) // TRUE if temp is between 24 and 28
	{
		return 2;		
	}
	else if ((lVtherm >= 280) && (lVtherm < 550)) // TRUE if temp is between 28 and 55
	{
		return 3;	
	}
	else
	{
		return 0;
	}			
}


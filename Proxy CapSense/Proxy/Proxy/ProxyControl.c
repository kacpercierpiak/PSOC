#include "ProxyControl.h" // Dodanie naglowka bilbioteki
#include <m8c.h> // Biblioteka zawierająca typy danych, stale etc.
#include "PSoCAPI.h" // Biblioteka zaweriajace funkcje dla peryferiów    

/// <summary>
/// Funkcja inicjalizująca czujnik światła
/// </summary>
/// <remarks> 
/// <para> CSD_Start() - inicjalizuje moduł CSD</para>
/// <para>CSD_InitializeBaselines() - Zaladowanie tablicy 
/// czujnikow CapSense</para>
/// <para>CSD_SetDefaultFingerThresholds() - aktywacja kalibracji modulu</para>
/// </remarks>
void ProxyControl_INIT(void)
{
  CSD_Start();   
  CSD_InitializeBaselines();   
  CSD_SetDefaultFingerThresholds();
}

/// <summary>
/// Funkcja waliduje wartość częstotliwości migania diody
/// </summary>
/// <remarks>
/// <para> CSD_ScanAllSensors() - Skanuje wszystkie skonfigurowane czujniki </para>
/// <para> CSD_UpdateAllBaselines() - Aktualizacja danych historycznych czujników</para>
/// <para> CSD_bIsAnySensorActive() - Sprawdza czy którykolwiek z czujnikow jest aktywny</para>
/// </remarks>
/// <returns>
/// <para> Zwracana jest wartosc TRUE/FALSE funkcji CSD_bIsAnySensorActive()</para>
/// </returns>
/// 
BOOL ProxyControl_Proxy(void)
{
  CSD_ScanAllSensors();
  CSD_UpdateAllBaselines();
  return CSD_bIsAnySensorActive();
}
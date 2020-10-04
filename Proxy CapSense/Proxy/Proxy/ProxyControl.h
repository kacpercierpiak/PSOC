/*
Dyrektywy zapobiegające dołączeniu tego samego pliku
więcej niż jeden raz do projektu
*/
#ifndef PROXYCONTROL_H_   
#define PROXYCONTROL_H_

//Bilbioteka umozliwiajaca wykorzystanie typu BOOL
#include <m8c.h>   

//Deklaracja funkcji
void ProxyControl_INIT(void);
BOOL ProxyControl_Proxy(void);

#endif 
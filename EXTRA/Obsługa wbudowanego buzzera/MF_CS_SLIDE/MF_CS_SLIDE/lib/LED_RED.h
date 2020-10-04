//*****************************************************************************
//*****************************************************************************
//  FILENAME: LED_RED.h
//   Version: 2.00, Updated on 2015/3/4 at 22:26:37                                          
//  Generated by PSoC Designer 5.4.3191
//
//  DESCRIPTION: LED_RED User Module C Language interface file
//-----------------------------------------------------------------------------
//  Copyright (c) Cypress Semiconductor 2015. All Rights Reserved.
//*****************************************************************************
//*****************************************************************************
#ifndef LED_RED_INCLUDE
#define LED_RED_INCLUDE

#include <m8c.h>


/* Create pragmas to support proper argument and return value passing */
#pragma fastcall16  LED_RED_Stop
#pragma fastcall16  LED_RED_Start
#pragma fastcall16  LED_RED_On
#pragma fastcall16  LED_RED_Off
#pragma fastcall16  LED_RED_Switch
#pragma fastcall16  LED_RED_Invert
#pragma fastcall16  LED_RED_GetState


//-------------------------------------------------
// Constants for LED_RED API's.
//-------------------------------------------------
//
#define  LED_RED_ON   1
#define  LED_RED_OFF  0

//-------------------------------------------------
// Prototypes of the LED_RED API.
//-------------------------------------------------
extern void  LED_RED_Start(void);                                     
extern void  LED_RED_Stop(void);                                      
extern void  LED_RED_On(void);                                      
extern void  LED_RED_Off(void);                                      
extern void  LED_RED_Switch(BYTE bSwitch);
extern void  LED_RED_Invert(void);                                         
extern BYTE  LED_RED_GetState(void);                                         

//-------------------------------------------------
// Define global variables.                 
//-------------------------------------------------



#endif

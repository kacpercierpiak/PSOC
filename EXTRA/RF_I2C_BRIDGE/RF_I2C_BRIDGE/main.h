//----------------------------------------------------------------------------
//
// <main.h> - Star Network Protocol Node
//
//--------------------------------------------------------------------------
//
//--------------------------------------------------------------------------
//
// Copyright 2008, Cypress Semiconductor Corporation.
//
// This software is owned by Cypress Semiconductor Corporation (Cypress)
// and is protected by and subject to worldwide patent protection (United
// States and foreign), United States copyright laws and international
// treaty provisions. Cypress hereby grants to licensee a personal,
// non-exclusive, non-transferable license to copy, use, modify, create
// derivative works of, and compile the Cypress Source Code and derivative
// works for the sole purpose of creating custom software in support of
// licensee product to be used only in conjunction with a Cypress integrated
// circuit as specified in the applicable agreement. Any reproduction,
// modification, translation, compilation, or representation of this
// software except as specified above is prohibited without the express
// written permission of Cypress.
//
// Disclaimer: CYPRESS MAKES NO WARRANTY OF ANY KIND,EXPRESS OR IMPLIED,
// WITH REGARD TO THIS MATERIAL, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
// Cypress reserves the right to make changes without further notice to the
// materials described herein. Cypress does not assume any liability arising
// out of the application or use of any product or circuit described herein.
// Cypress does not authorize its products for use as critical components in
// life-support systems where a malfunction or failure may reasonably be
// expected to result in significant injury to the user. The inclusion of
// Cypress' product in a life-support systems application implies that the
// manufacturer assumes all risk of such use and in doing so indemnifies
// Cypress against all charges.
//
// Use may be limited by and subject to the applicable Cypress software
// license agreement.
//
//--------------------------------------------------------------------------
#ifndef MAIN_H
#define MAIN_H

#include <m8c.h>        // part specific constants and macros
#include "PSoCAPI.h"    // PSoC API definitions for all User Modules
#include "psocGpioInt.h"


//-------------------------------------------------------------------------
//
//#defines
//
//-------------------------------------------------------------------------

#define ON_THE_FLY_DEV_ID    0x00

#define LED_HEARTBEAT_SEC   5   // Heartbeat LED blink rate (in Sec)
#define REPORT_TIME_SEC     5   // Default reporting time (in Sec)

#define SNP_RUN_SCALER      2   // Run SNP every 2nd cycle (every ~30mS)
static BYTE snpRunScaler;       // Slow-down CYFISNP_Run() to save energy

#define DEBOUNCE_TIME   2

#define LOW_POWER_TEST 1


#define ChipSelect_ON   (ChipSelect_Data_ADDR |= ChipSelect_MASK)
#define ChipSelect_OFF  (ChipSelect_Data_ADDR &= ~ChipSelect_MASK)

#define IS_DataReady_ON (DataReady_Data_ADDR & DataReady_MASK)

#define SLAVE_ADDRESS 0x05

// ---------------------------------------------------------------------------
// Wait up to 300 mS for Weather Station board to respond
// ---------------------------------------------------------------------------
#define DATA_READY_TIME   (300 / CYFISNP_TIMER_UNITS)


#define I2C_PAYLOAD_MAX 8

//-------------------------------------------------------------------------
//
// Global Variables
//
//-------------------------------------------------------------------------

static CYFISNP_API_PKT  txApiPkt;       // Local Tx Data buffer

WORD ledHeartbeatSec = LED_HEARTBEAT_SEC;

WORD reportTimeSec  = REPORT_TIME_SEC;
WORD reportTimerSec = REPORT_TIME_SEC;

WORD sleepTicksPerSec = 64;     // 64 sleep timer ticks is "nominally" 1 sec
WORD oneSecTimer;


BYTE rxBuffer[I2C_PAYLOAD_MAX];
//BYTE rxData[CYFISNP_FCD_PAYLOAD_MAX];
//BYTE status;


#define LED_RED_OFF     (RedLED_Data_ADDR &= ~RedLED_MASK)
#define LED_RED_ON      (RedLED_Data_ADDR |=  RedLED_MASK)
#define LED_RED_TOG     (RedLED_Data_ADDR ^=  RedLED_MASK)
#define IS_LED_RED_ON   (RedLED_Data_ADDR &   RedLED_MASK)

#define LED_GRN_OFF     (GreenLED_Data_ADDR &= ~GreenLED_MASK)
#define LED_GRN_ON      (GreenLED_Data_ADDR |=  GreenLED_MASK)
#define LED_GRN_TOG     (GreenLED_Data_ADDR ^=  GreenLED_MASK)
#define IS_LED_GRN_ON   (GreenLED_Data_ADDR &   GreenLED_MASK)

//Thermistor ON and OFF defines
#define Port2_DataShade_ON  (Port_2_Data_SHADE|=Vtherm_div_MASK)
#define Port2_DataShade_OFF (Port_2_Data_SHADE &= ~Vtherm_div_MASK)
#define Vtherm_div_OFF      (Vtherm_div_Data_ADDR = Port2_DataShade_OFF)
#define Vtherm_div_ON       (Vtherm_div_Data_ADDR = Port2_DataShade_ON)


#endif


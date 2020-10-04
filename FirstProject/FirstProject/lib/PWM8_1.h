//*****************************************************************************
//*****************************************************************************
//  FILENAME: PWM8_1.h
//   Version: 2.60, Updated on 2015/3/4 at 22:26:52
//  Generated by PSoC Designer 5.4.3191
//
//  DESCRIPTION: PWM8 User Module C Language interface file
//-----------------------------------------------------------------------------
//  Copyright (c) Cypress Semiconductor 2015. All Rights Reserved.
//*****************************************************************************
//*****************************************************************************
#ifndef PWM8_1_INCLUDE
#define PWM8_1_INCLUDE

#include <m8c.h>

#pragma fastcall16 PWM8_1_EnableInt
#pragma fastcall16 PWM8_1_DisableInt
#pragma fastcall16 PWM8_1_Start
#pragma fastcall16 PWM8_1_Stop
#pragma fastcall16 PWM8_1_bReadCounter              // Read  DR0
#pragma fastcall16 PWM8_1_WritePeriod               // Write DR1
#pragma fastcall16 PWM8_1_bReadPulseWidth           // Read  DR2
#pragma fastcall16 PWM8_1_WritePulseWidth           // Write DR2

// The following symbols are deprecated.
// They may be omitted in future releases
//
#pragma fastcall16 bPWM8_1_ReadCounter              // Read  DR0 (Deprecated)
#pragma fastcall16 bPWM8_1_ReadPulseWidth           // Read  DR2 (Deprecated)


//-------------------------------------------------
// Prototypes of the PWM8_1 API.
//-------------------------------------------------

extern void PWM8_1_EnableInt(void);                        // Proxy Class 1
extern void PWM8_1_DisableInt(void);                       // Proxy Class 1
extern void PWM8_1_Start(void);                            // Proxy Class 1
extern void PWM8_1_Stop(void);                             // Proxy Class 1
extern BYTE PWM8_1_bReadCounter(void);                     // Proxy Class 2
extern void PWM8_1_WritePeriod(BYTE bPeriod);              // Proxy Class 1
extern BYTE PWM8_1_bReadPulseWidth(void);                  // Proxy Class 1
extern void PWM8_1_WritePulseWidth(BYTE bPulseWidth);      // Proxy Class 1

// The following functions are deprecated.
// They may be omitted in future releases
//
extern BYTE bPWM8_1_ReadCounter(void);            // Deprecated
extern BYTE bPWM8_1_ReadPulseWidth(void);         // Deprecated


//--------------------------------------------------
// Constants for PWM8_1 API's.
//--------------------------------------------------

#define PWM8_1_CONTROL_REG_START_BIT           ( 0x01 )
#define PWM8_1_INT_REG_ADDR                    ( 0x0e1 )
#define PWM8_1_INT_MASK                        ( 0x01 )


//--------------------------------------------------
// Constants for PWM8_1 user defined values
//--------------------------------------------------

#define PWM8_1_PERIOD                          ( 0x64 )
#define PWM8_1_PULSE_WIDTH                     ( 0x19 )


//-------------------------------------------------
// Register Addresses for PWM8_1
//-------------------------------------------------

#pragma ioport  PWM8_1_COUNTER_REG: 0x020                  //DR0 Count register
BYTE            PWM8_1_COUNTER_REG;
#pragma ioport  PWM8_1_PERIOD_REG:  0x021                  //DR1 Period register
BYTE            PWM8_1_PERIOD_REG;
#pragma ioport  PWM8_1_COMPARE_REG: 0x022                  //DR2 Compare register
BYTE            PWM8_1_COMPARE_REG;
#pragma ioport  PWM8_1_CONTROL_REG: 0x023                  //Control register
BYTE            PWM8_1_CONTROL_REG;
#pragma ioport  PWM8_1_FUNC_REG:    0x120                  //Function register
BYTE            PWM8_1_FUNC_REG;
#pragma ioport  PWM8_1_INPUT_REG:   0x121                  //Input register
BYTE            PWM8_1_INPUT_REG;
#pragma ioport  PWM8_1_OUTPUT_REG:  0x122                  //Output register
BYTE            PWM8_1_OUTPUT_REG;
#pragma ioport  PWM8_1_INT_REG:       0x0e1                //Interrupt Mask Register
BYTE            PWM8_1_INT_REG;


//-------------------------------------------------
// PWM8_1 Macro 'Functions'
//-------------------------------------------------

#define PWM8_1_Start_M \
   PWM8_1_CONTROL_REG |=  PWM8_1_CONTROL_REG_START_BIT

#define PWM8_1_Stop_M  \
   PWM8_1_CONTROL_REG &= ~PWM8_1_CONTROL_REG_START_BIT

#define PWM8_1_EnableInt_M   \
   M8C_EnableIntMask(PWM8_1_INT_REG, PWM8_1_INT_MASK)

#define PWM8_1_DisableInt_M  \
   M8C_DisableIntMask(PWM8_1_INT_REG, PWM8_1_INT_MASK)

#endif
// end of file PWM8_1.h

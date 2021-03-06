//*****************************************************************************
//*****************************************************************************
//  FILENAME: PWM16.h
//   Version: 2.5, Updated on 2015/3/4 at 22:26:51
//  Generated by PSoC Designer 5.4.3191
//
//  DESCRIPTION: PWM16 User Module C Language interface file
//-----------------------------------------------------------------------------
//  Copyright (c) Cypress Semiconductor 2015. All Rights Reserved.
//*****************************************************************************
//*****************************************************************************
#ifndef PWM16_INCLUDE
#define PWM16_INCLUDE

#include <m8c.h>

#pragma fastcall16 PWM16_EnableInt
#pragma fastcall16 PWM16_DisableInt
#pragma fastcall16 PWM16_Start
#pragma fastcall16 PWM16_Stop
#pragma fastcall16 PWM16_wReadCounter              // Read  DR0
#pragma fastcall16 PWM16_WritePeriod               // Write DR1
#pragma fastcall16 PWM16_wReadPulseWidth           // Read  DR2
#pragma fastcall16 PWM16_WritePulseWidth           // Write DR2

// The following symbols are deprecated.
// They may be omitted in future releases
//
#pragma fastcall16 wPWM16_ReadCounter              // Read  DR0 (Deprecated)
#pragma fastcall16 wPWM16_ReadPulseWidth           // Read  DR2 (Deprecated)


//-------------------------------------------------
// Prototypes of the PWM16 API.
//-------------------------------------------------

extern void PWM16_EnableInt(void);                  // Proxy Class 1
extern void PWM16_DisableInt(void);                 // Proxy Class 1
extern void PWM16_Start(void);                      // Proxy Class 1
extern void PWM16_Stop(void);                       // Proxy Class 1
extern WORD PWM16_wReadCounter(void);               // Proxy Class 2
extern void PWM16_WritePeriod(WORD wPeriod);        // Proxy Class 1
extern WORD PWM16_wReadPulseWidth(void);            // Proxy Class 1
extern void PWM16_WritePulseWidth(WORD wPulseWidth);// Proxy Class 1

// The following functions are deprecated.
// They may be omitted in future releases
//
extern WORD wPWM16_ReadCounter(void);            // Deprecated
extern WORD wPWM16_ReadPulseWidth(void);         // Deprecated


//-------------------------------------------------
// Constants for PWM16 API's.
//-------------------------------------------------

#define PWM16_CONTROL_REG_START_BIT            ( 0x01 )
#define PWM16_INT_REG_ADDR                     ( 0x0e1 )
#define PWM16_INT_MASK                         ( 0x04 )


//--------------------------------------------------
// Constants for PWM16 user defined values
//--------------------------------------------------

#define PWM16_PERIOD                           ( 0x1f4 )
#define PWM16_PULSE_WIDTH                      ( 0x64 )


//-------------------------------------------------
// Register Addresses for PWM16
//-------------------------------------------------

#pragma ioport  PWM16_COUNTER_LSB_REG:  0x024              //DR0 Count register LSB
BYTE            PWM16_COUNTER_LSB_REG;
#pragma ioport  PWM16_COUNTER_MSB_REG:  0x028              //DR0 Count register MSB
BYTE            PWM16_COUNTER_MSB_REG;
#pragma ioport  PWM16_PERIOD_LSB_REG:   0x025              //DR1 Period register LSB
BYTE            PWM16_PERIOD_LSB_REG;
#pragma ioport  PWM16_PERIOD_MSB_REG:   0x029              //DR1 Period register MSB
BYTE            PWM16_PERIOD_MSB_REG;
#pragma ioport  PWM16_COMPARE_LSB_REG:  0x026              //DR2 Compare register LSB
BYTE            PWM16_COMPARE_LSB_REG;
#pragma ioport  PWM16_COMPARE_MSB_REG:  0x02a              //DR2 Compare register MSB
BYTE            PWM16_COMPARE_MSB_REG;
#pragma ioport  PWM16_CONTROL_LSB_REG:  0x027              //Control register LSB
BYTE            PWM16_CONTROL_LSB_REG;
#pragma ioport  PWM16_CONTROL_MSB_REG:  0x02b              //Control register MSB
BYTE            PWM16_CONTROL_MSB_REG;
#pragma ioport  PWM16_FUNC_LSB_REG: 0x124                  //Function register LSB
BYTE            PWM16_FUNC_LSB_REG;
#pragma ioport  PWM16_FUNC_MSB_REG: 0x128                  //Function register MSB
BYTE            PWM16_FUNC_MSB_REG;
#pragma ioport  PWM16_INPUT_LSB_REG:    0x125              //Input register LSB
BYTE            PWM16_INPUT_LSB_REG;
#pragma ioport  PWM16_INPUT_MSB_REG:    0x129              //Input register MSB
BYTE            PWM16_INPUT_MSB_REG;
#pragma ioport  PWM16_OUTPUT_LSB_REG:   0x126              //Output register LSB
BYTE            PWM16_OUTPUT_LSB_REG;
#pragma ioport  PWM16_OUTPUT_MSB_REG:   0x12a              //Output register MSB
BYTE            PWM16_OUTPUT_MSB_REG;
#pragma ioport  PWM16_INT_REG:       0x0e1                 //Interrupt Mask Register
BYTE            PWM16_INT_REG;


//-------------------------------------------------
// PWM16 Macro 'Functions'
//-------------------------------------------------

#define PWM16_Start_M \
   ( PWM16_CONTROL_LSB_REG |=  PWM16_CONTROL_REG_START_BIT )

#define PWM16_Stop_M  \
   ( PWM16_CONTROL_LSB_REG &= ~PWM16_CONTROL_REG_START_BIT )

#define PWM16_EnableInt_M   \
   M8C_EnableIntMask(  PWM16_INT_REG, PWM16_INT_MASK )

#define PWM16_DisableInt_M  \
   M8C_DisableIntMask( PWM16_INT_REG, PWM16_INT_MASK )

#endif
// end of file PWM16.h

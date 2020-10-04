//*****************************************************************************
//*****************************************************************************
//  FILENAME: I2C.h
//   Version: 1.90, Updated on 2011/6/28 at 6:9:30
//  Generated by PSoC Designer 5.1.2306
//
//  DESCRIPTION: I2Cs User Module C Language interface file
//-----------------------------------------------------------------------------
//  Copyright (c) Cypress Semiconductor 2011. All Rights Reserved.
//*****************************************************************************
//*****************************************************************************

#include <m8c.h>

#ifndef I2C_ADDR_REG_PRESENT
#define I2C_ADDR_REG_PRESENT                 0                       //CY8C28X45 have 1 always while all other have 0
#endif
#define I2C_AUTO_ADDR_CHECK                  0                       //CY8C28X45 may have this 0 or 1 while all other have 0

/* Create pragmas to support proper argument and return value passing */
#pragma fastcall16  I2C_Start
#pragma fastcall16  I2C_DisableInt
#pragma fastcall16  I2C_ResumeInt
#pragma fastcall16  I2C_EnableInt
#pragma fastcall16  I2C_ClearInt
#pragma fastcall16  I2C_Stop
#ifdef I2C_SLAVE_INCLUDE
#pragma fastcall16  I2C_EnableSlave
#pragma fastcall16  I2C_DisableSlave
#endif
#ifdef I2C_MSTR_INCLUDE
#pragma fastcall16  I2C_EnableMstr
#pragma fastcall16  I2C_DisableMstr
#endif
#pragma fastcall16  I2C_InitWrite
#pragma fastcall16  I2C_InitRamRead
#pragma fastcall16  I2C_InitFlashRead
#pragma fastcall16  I2C_bReadI2CStatus
#pragma fastcall16  I2C_ClrRdStatus
#pragma fastcall16  I2C_ClrWrStatus

//-------------------------------------------------
// pragma register definitions.
//-------------------------------------------------
#pragma ioport  I2C_CFG:    0x0d6                               // I2C Status and Control Register
BYTE            I2C_CFG;

#define  I2C_BUSERRIE    0x20
#define  I2C_STOPIE      0x10
#define  I2C_CLKR1       0x08
#define  I2C_CLKR0       0x04
#define  I2C_M_EN        0x02
#define  I2C_S_EN        0x01

#pragma ioport  I2C_SCR:    0x0d7                               // I2C Status and Control Register
BYTE            I2C_SCR;

#define  I2CM_BUSERR     0x80
#define  I2CM_LOSTARB    0x40
#define  I2C_STOP_ST     0x20
#define  I2C_ACKOUT      0x10
#define  I2C_ADDRIN      0x08
#define  I2C_TX          0x04 //compliment is RX
#define  I2C_LST_BIT     0x02
#define  I2C_BYTE_COMPL  0x01

#pragma ioport  I2C_DR: 0x0d8                                   // I2C Status and Control Register
BYTE            I2C_DR;

#pragma ioport  I2C_MSCR:   0x0d9                               // I2C Status and Control Register
BYTE            I2C_MSCR;

#define  I2CM_BUSBUSY    0x08
#define  I2CM_MASTEROP   0x04
#define  I2CM_RESTRT     0x02
#define  I2CM_SNDSTRT    0x01

#if (I2C_ADDR_REG_PRESENT)
@ADDR_IOH                                                       // I2C Address Register
@ADDR_H
#endif

//-------------------------------------------------
// Prototypes of the I2C API.
//-------------------------------------------------
extern void  I2C_Start(void);		                                      //proxy class 1
extern void  I2C_DisableInt(void);		                                 //proxy class 1
extern void  I2C_ResumeInt(void);                                    //proxy class 1
extern void  I2C_EnableInt(void);		                                  //proxy class 1
extern void  I2C_ClearInt(void);		                                   //proxy class 1
extern void  I2C_Stop(void);		                                       //proxy class 1
#ifdef I2C_SLAVE_INCLUDE
extern void  I2C_EnableSlave(void);	                                 //proxy class 1
extern void  I2C_DisableSlave(void);	                                //proxy class 1
#endif
#ifdef I2C_MSTR_INCLUDE
extern void  I2C_EnableMstr(void);		                                 //proxy class 1
extern void  I2C_DisableMstr(void);	                                 //proxy class 1
#endif
extern void  I2C_InitWrite(BYTE * pI2C_WriteBuf, BYTE  I2C_Write_Count);	      //proxy class 1
extern void  I2C_InitRamRead(BYTE * pI2C_ReadBuf, BYTE  I2C_Read_Count);	      //proxy class 1
extern void  I2C_InitFlashRead(const BYTE * pI2C_flashaddr,  unsigned int I2C_Read_CountHI);	   //proxy class 1
extern BYTE  I2C_bReadI2CStatus(void);	                              //proxy class 1
extern void  I2C_ClrRdStatus(void);	                                 //proxy class 1
extern void  I2C_ClrWrStatus(void);	                                 //proxy class 1


#define I2C_READ_BUFTYPE                     0x0

//I2C_SlaveStatus byte, Status Bit definitions
#define  I2CHW_RD_NOERR                      0x01     //read completed without errors
#define  I2CHW_RD_OVERFLOW                   0x02     //master read more bytes than were contained in read buffer
#define  I2CHW_RD_COMPLETE                   0x04     //last read transaction is complete
#define  I2CHW_READFLASH                     0x08     //set- next read will use flash read buffer, clear- next read will use ram read buffer
#define  I2CHW_WR_NOERR                      0x10     //write completed without errors
#define  I2CHW_WR_OVERFLOW                   0x20     //received bytes exceeded write buffer length
#define  I2CHW_WR_COMPLETE                   0x40     //indicates either a stop or new addr was rec'd after a write to slave.
#define  I2CHW_ISR_NEW_ADDR                  0x40     //New address received (can infer that previous transaction is complete)
#define  I2CHW_ISR_ACTIVE                    0x80     //ISR for I2C is active

// end of file I2C.h

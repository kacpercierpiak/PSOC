//*****************************************************************************
//*****************************************************************************
//  FILENAME: CYFISNP_Protocol.h
//  Version: 2.00, Updated on 2015/3/4 at 22:21:19
//  Generated by PSoC Designer 5.4.3191
//
//  DESCRIPTION: <NODE> Star Network Protocol implementation
//-----------------------------------------------------------------------------
//  Copyright (c) Cypress Semiconductor 2015. All Rights Reserved.
//*****************************************************************************
//*****************************************************************************

#ifndef CYFISNP_PROTOCOL_H
#define CYFISNP_PROTOCOL_H

#include <m8c.h>
#include "CYFISNP_Config.h"

#pragma fastcall16 CYFISNP_SleepTimer_Set64Hz
void CYFISNP_SleepTimer_Set64Hz(void);


// ---------------------------------------------------------------------------
//
// CYFISNP_eProtState - Overall Protocol State
//
// ---------------------------------------------------------------------------
typedef enum {
    CYFISNP_BIND_MODE           = 0x10,  // Binding (not Data Mode)
    CYFISNP_UNBOUND_MODE        = 0x11,  // (Node only)
    CYFISNP_CON_MODE            = 0x20,  // (Node only)
    CYFISNP_CON_MODE_TIMEOUT    = 0x21,  // (Node only)
    CYFISNP_PING_MODE           = 0x30,  // Lost contact with Hub
    CYFISNP_PING_MODE_TIMEOUT   = 0x31,  // (Node only)
    CYFISNP_DATA_MODE           = 0x40,  // Last packet was AutoACKed
    CYFISNP_STOP_MODE           = 0x50,
} CYFISNP_PROT_STATE;
extern CYFISNP_PROT_STATE CYFISNP_eProtState;



// ---------------------------------------------------------------------------
//
// CYFISNP_API_PKT - Packet structure between Protocol and API
//
// ---------------------------------------------------------------------------
#define   CYFISNP_API_TYPE_CONF         0x10  // Deliv confirm, no BCDR
#define   CYFISNP_API_TYPE_CONF_BCDR    0x20  // Deliv confirm, BCDR
#define   CYFISNP_API_TYPE_SYNC         0x30  // Best effort, no BCDR
#define   CYFISNP_API_TYPE_SYNC_BCDR    0x40  // Best effort, BCDR

typedef struct {                        //
    BYTE length;                        // Payload length
    BYTE rssi;                          // RSSI of packet
    BYTE type;                          // Packet type
    BYTE devId;                         // [7:0] = Device ID
    BYTE payload[14];
} CYFISNP_API_PKT;



// ---------------------------------------------------------------------------
//
// CYFISNP_CurrentChannel - API may view current channel for informative purposes only
//
// ---------------------------------------------------------------------------
extern BYTE CYFISNP_bCurrentChannel;


// ---------------------------------------------------------------------------
//
// Public Functions
//
// ---------------------------------------------------------------------------
#pragma fastcall16 CYFISNP_PhyStart
#pragma fastcall16 CYFISNP_PhyStop

#define					CYFISNP_LookupDevId     CYFISNP_GetNodeID

BYTE            CYFISNP_Start           (void);
void            CYFISNP_Run             (void);
BYTE            CYFISNP_PhyStart        (void);
void            CYFISNP_PhyStop         (void);
void            CYFISNP_Stop            (void);
void            CYFISNP_Jog             (void);
void            CYFISNP_BindStart       (BYTE DevID);

BOOL            CYFISNP_TxDataPend      (void);
BOOL            CYFISNP_TxDataPut       (CYFISNP_API_PKT *ps);

BOOL            CYFISNP_RxDataPend      (void);
CYFISNP_API_PKT *   CYFISNP_RxDataGet       (void);
void            CYFISNP_RxDataRelease   (void);

void            CYFISNP_Unbind          (void);
BYTE            CYFISNP_GetNodeID       (void);
BYTE            CYFISNP_GetDieTemp      (void);

BYTE            CYFISNP_GetQualGfsk     (void);     // Debug access for API
BYTE            CYFISNP_GetQual8dr      (void);     // Debug access for API


// ---------------------------------------------------------------------------
//
// SPI Power Management (most applications can ignore these API functions)
//
//  The underlying radio CYRF6936 uses a 4-wire SPI interface and (for battery
//   powered applications), SNP tri-states the SPI lines to minimize leakage
//   currents in some cases.  Some of these CYRF3936 MAY be useful to a battery
//   powered application (some GPIOs, a low-voltage detector, etc).
//   The app should call _spiWake() before trying to read from the radio.
// ---------------------------------------------------------------------------
#if (CYFISNP_PWR_TYPE == CYFISNP_PWR_WALL) // SPI always ON
    #define CYFISNP_spiSleep()
    #define CYFISNP_spiWake()
#else                                           // Sleep SPI when Sleep Radio
    void    CYFISNP_spiSleep    (void);     // Set SPI to minimize leakage current
    void    CYFISNP_spiWake     (void);     // Set SPI to communicate w/Radio
#endif


#endif  // CYFISNP_PROTOCOL_H
// ###########################################################################
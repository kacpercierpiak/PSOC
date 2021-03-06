//*****************************************************************************
//*****************************************************************************
//  FILENAME: CYFISNP_Config.h
//  Version: 2.00, Updated on 2015/3/4 at 22:21:19
//  Generated by PSoC Designer 5.4.3191
//
//  DESCRIPTION: <NODE> Star Network Protocol User and Target Configuration
//-----------------------------------------------------------------------------
//  Copyright (c) Cypress Semiconductor 2015. All Rights Reserved.
//*****************************************************************************
//*****************************************************************************

#ifndef CYFISNP_CONFIG_H
#define CYFISNP_CONFIG_H

#include <m8c.h>

#define CYFISNP_FLASH_BLOCK_NUMBER_IS_WORD   0

// ---------------------------------------------------------------------------
//
// External PA installed
//
// ---------------------------------------------------------------------------
#define CYFISNP_EXTERNAL_PA    0  // NZ = external PA

#ifdef CYFISNP_PROTOCOL_C      // Only present in <protocol.c> file
// ---------------------------------------------------------------------------
//
// PA_PHY_TBL - An 8-entry Flash lookup table defining the Radio PA_Setting.
//
//  If an external PA is installed, the first table used.
//  If no external PA is installed, the second table is used.
//
// ---------------------------------------------------------------------------
#define PA0         0x00            // typically -35 dBm
#define PA1         0x01            // typically -30 dBm
#define PA2         0x02            // typically -24 dBm
#define PA3         0x03            // typically -18 dBm
#define PA4         0x04            // typically -13 dBm
#define PA5         0x05            // typically - 5 dBm
#define PA6         0x06            // typically   0 dBm
#define PA7         0x07            // typically  +4 dBm
// The following are only functional when an external PA is installed
#if (CYFISNP_EXTERNAL_PA)
#define EXT_PA_ON   0x10
#define PA0_PLUS    (PA0+EXT_PA_ON) // typically external_PA_gain + -35 dBm
#define PA1_PLUS    (PA1+EXT_PA_ON) // typically external_PA_gain + -30 dBm
#define PA2_PLUS    (PA2+EXT_PA_ON) // typically external_PA_gain + -24 dBm
#define PA3_PLUS    (PA3+EXT_PA_ON) // typically external_PA_gain + -18 dBm
#define PA4_PLUS    (PA4+EXT_PA_ON) // typically external_PA_gain + -13 dBm
#define PA5_PLUS    (PA5+EXT_PA_ON) // typically external_PA_gain + - 5 dBm
#define PA6_PLUS    (PA6+EXT_PA_ON) // typically external_PA_gain +   0 dBm
#define PA7_PLUS    (PA7+EXT_PA_ON) // typically external_PA_gain +  +4 dBm
#endif
const BYTE CYFISNP_PA_PHY_TBL[8] = {
    #if   (CYFISNP_EXTERNAL_PA == 0)
	PA0, PA1, PA2, PA3, PA4, PA5, PA6, PA6
    #else       // External PA
// ---------------------------------------------------------------------------
// @PSoC_UserCode_PaPhyTblExternal_00@ (Do not change this line.)
// Insert your custom declarations below this banner
//              THIS LIST SHOULD BE MONOTONIC FOR PROPER OPERATION
// ---------------------------------------------------------------------------
    // -----------------------------------------------------------------------
    //  Example Table for First Touch RF using a CR2032 coin cell.  Here, an
    //  external PA is present, but bypassed because the coin-cell (unlike
    //  alkaline cells) can't supply high peak current needed by external PA.
    // -----------------------------------------------------------------------
//  PA4,    // [0] Minimum  No current saved below PA4
//  PA4,    // [1]          No current saved below PA4
//  PA4,    // [2]          No current saved below PA4
//  PA4,    // [3]          No current saved below PA4
//  PA4,    // [4]          No current saved below PA4
//  PA5,    // [5]
//  PA6,    // [6]
//  PA6,    // [7] Maximum  Max Internal is PA6
    // -----------------------------------------------------------------------
    //  This table uses the external PA up to about +10dBm
    // -----------------------------------------------------------------------
	PA4,        // [0] Minimum
    PA4,        // [1] No current saved below PA4
    PA4,        // [2] No current saved below PA4
    PA4,        // [3] No current saved below PA4
    PA5,        // [4]
    PA6,        // [5]
    PA3_PLUS,   // [6]
    PA4_PLUS,   // [7] Maximum  (~+10 dBm for FirstTouch RF)
    // -----------------------------------------------------------------------
    //  Example Table for FirstTouch RF using MAXIMUM power
    // -----------------------------------------------------------------------
//  PA4,        // [0] Minimum  No current saved below PA4
//  PA5,        // [1]
//  PA6,        // [2]
//  PA3_PLUS,   // [3]
//  PA4_PLUS,   // [4]
//  PA5_PLUS,   // [5]
//  PA6_PLUS,   // [6]
//  PA7_PLUS    // [7] Maximum  (~+20 dBm for FirstTouch RF)
// ---------------------------------------------------------------------------
// Insert your custom declarations above this banner
// @PSoC_UserCode_END@ (Do not change this line.)
// ---------------------------------------------------------------------------
    #endif
};


// ---------------------------------------------------------------------------
// PA_LEVEL_BIND - Influences the binding distance.
//   This value is specified per the names given in PA_PHY_TBL[] above.
//   The value PA4 likely binds across a tabletop, but maybe not across a room.
// ---------------------------------------------------------------------------

#define CYFISNP_PA_LEVEL_BIND      PA6

#else
// ---------------------------------------------------------------------------
// Not PROTOCOL_C file, so declare _PA_PHY_TBL as extern (maybe debug use?)
// ---------------------------------------------------------------------------
extern const BYTE CYFISNP_PA_PHY_TBL[8];

#endif // CYFISNP_PROTOCOL_C


// ---------------------------------------------------------------------------
//
// Power source: Wall, alkaline, or coin-cell       (Set by UM GUI Property)
//
// ---------------------------------------------------------------------------

#define CYFISNP_PWR_BAT     0  // Battery w/High peak current (alkaline)
#define CYFISNP_PWR_WALL    1  // Wall powered (don't sleep)
#define CYFISNP_PWR_COIN    2  // Battery w/Low peak current (coin-cell)
#define CYFISNP_PWR_TYPE    0x0


// ---------------------------------------------------------------------------
//
// Back Channel Data Payload Length, user editable
//
// ---------------------------------------------------------------------------
// Insert your custom declarations below this banner
// @PSoC_UserCode_BcdPayloadMaxl_00@ (Do not change this line.)
// ---------------------------------------------------------------------------
#define CYFISNP_BCD_PAYLOAD_MAX     5      // 14 Bytes max
// ---------------------------------------------------------------------------
// Insert your custom declarations above this banner
// @PSoC_UserCode_END@ (Do not change this line.)
// ---------------------------------------------------------------------------


// ---------------------------------------------------------------------------
//
// Forward Channel Data Payload Length, user editable (but Hub must receive)
//
// ---------------------------------------------------------------------------
// @PSoC_UserCode_FcdPayloadMax_00@ (Do not change this line.)
// Insert your custom declarations below this banner
// ---------------------------------------------------------------------------
#define CYFISNP_FCD_PAYLOAD_MAX     14     // 14 Bytes max
// ---------------------------------------------------------------------------
// Insert your custom declarations above this banner
// @PSoC_UserCode_END@ (Do not change this line.)
// ---------------------------------------------------------------------------


// ---------------------------------------------------------------------------
//
// EEP_BASE - EEPROM Pointer to base of FLASH Device Records (set by UM Property)
//
// ---------------------------------------------------------------------------


#if (CYFISNP_PSOC_EXPRESS_PROJECT)
    #define CYFISNP_EEP_PHY_ADR     FirstConstBlock
#else
    #define CYFISNP_EEP_PHY_ADR     (0xff * 0x40)
#endif


// ---------------------------------------------------------------------------
//
// Bind Mode Network Parameters used during Hub/Node Bind Req/Rsp.  Casual
//   User's won't change bind sop/seed, but someday someone may want to change.
//   Hub and Node settings MUST match to bind.
// ---------------------------------------------------------------------------
// Insert your custom declarations below this banner
// @PSoC_UserCode_BindParameters_00@ (Do not change this line.)
// ---------------------------------------------------------------------------
#define CYFISNP_BIND_MODE_SOP           0       // {0-9} = Bind SOP Code
#define CYFISNP_BIND_MODE_CRC_SEED      0       //    0  = Bind CRC Seed
// ---------------------------------------------------------------------------
// Insert your custom declarations above this banner
// @PSoC_UserCode_END@ (Do not change this line.)
// ---------------------------------------------------------------------------

#ifdef CYFISNP_PROTOCOL_C  // Visibility only in <protocol.c>
// ---------------------------------------------------------------------------
//
// Bind Mode Network Channels used during Hub/Node Bind Req/Rsp.
//   Hub and Node settings MUST match to bind.
//
// NOTE: this table uses "channel" numbers, and are 2MHz LESS THAN frequency.
//       So Channel 0 = 2.402GHz and Channel 77 = 2.479GHz
// ---------------------------------------------------------------------------
const BYTE CYFISNP_BIND_CH_SEQ[] = {
    0xa,     // Value from User Module "First Channel" Property
// ---------------------------------------------------------------------------
// @PSoC_UserCode_BindChannels_00@ (Do not change this line.)
// Insert your custom declarations below this banner
// ---------------------------------------------------------------------------
    14,     // 2.416 GHz
    31,     // 2.433 GHz
    46,     // 2.448 GHz
    56,     // 2.458 GHz
// ---------------------------------------------------------------------------
// Insert your custom declarations above this banner
// @PSoC_UserCode_END@ (Do not change this line.)
// ---------------------------------------------------------------------------
    0x3a       // Value from User Module "Last Channel" Property
    };

#endif  // CYFISNP_PROTOCOL_C
#endif  // CYFISNP_CONFIG_H
// ###########################################################################

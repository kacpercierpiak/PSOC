//*****************************************************************************
//*****************************************************************************
//  FILENAME: CYFISNP_Time.c
//  Version: 2.00, Updated on 2011/6/28 at 6:7:54
//  Generated by PSoC Designer 5.1.2306
//
//  DESCRIPTION: <NODE> Star Network Protocol Protocol Time routines
//-----------------------------------------------------------------------------
//  Copyright (c) Cypress Semiconductor 2011. All Rights Reserved.
//*****************************************************************************
//*****************************************************************************

#include <m8c.h>
#include "CYFISNP_Time.h"
#include "CYFISNP_Config.h"

#if (CYFISNP_PSOC_EXPRESS_PROJECT)
    #include "SystemTimer.h"
    extern WORD SystemTimer_TickCount;
#else
    //#include "SleepTimer.h"
    extern WORD SleepTimer_TickCount;
#endif


// ---------------------------------------------------------------------------
// SleepTimer_TickCount = free-running 16-bit incrementing Tick counter from
//                         SleepTimer User Module.
// ---------------------------------------------------------------------------


// ---------------------------------------------------------------------------
//
// CYFISNP_TimeSet()     -  Set caller's timer for polling
// CYFISNP_TimeExpired() - Poll caller's timer
//
// ---------------------------------------------------------------------------


// ---------------------------------------------------------------------------
// This specifies a decrementing Tick Counter instead of incrementing
// ---------------------------------------------------------------------------
//#define SYSTIMER_DECREMENTS


    void
CYFISNP_TimeSet(
    WORD *pTimer,           // Ptr to store expiration time
    WORD time               // 32767 counts maximum
    ) {                     // -----------------------------------------------
    WORD tmpTime;
    M8C_DisableIntMask(INT_MSK0, INT_MSK0_SLEEP);
#if (CYFISNP_PSOC_EXPRESS_PROJECT)
    tmpTime = SystemTimer_TickCount;
#else
    tmpTime = SleepTimer_TickCount;
#endif
    M8C_EnableIntMask(INT_MSK0, INT_MSK0_SLEEP);
#ifdef SYSTIMER_DECREMENTS      // free-running Timer decrements
    *pTimer = tmpTime - time;
#else                           // CYFISNP_SysTimer16 increments
    *pTimer = tmpTime + time;
#endif

}
    BOOL                    // Ret TRUE if expired
CYFISNP_TimeExpired(
    WORD *pTimer            // ptr to expiration time
    ) {                     // -----------------------------------------------
    WORD tmpTime;
    M8C_DisableIntMask(INT_MSK0, INT_MSK0_SLEEP);
#if (CYFISNP_PSOC_EXPRESS_PROJECT)
    tmpTime = SystemTimer_TickCount;
#else
    tmpTime = SleepTimer_TickCount;
#endif
    M8C_EnableIntMask(INT_MSK0, INT_MSK0_SLEEP);
#ifdef SYSTIMER_DECREMENTS
    tmpTime = tmpTime - *pTimer;
#else
    tmpTime = *pTimer - tmpTime;
#endif
    if (((BYTE)(tmpTime>>8)&0x80) == 0)     return FALSE;   // not expired
    else                                    return TRUE;    // expired
}

// ###########################################################################

//----------------------------------------------------------------------------
//
// Main.c - FirstTouch I2C Bridge
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


#include "main.h"

static void sendNewTxMsg    (void);
static void loadTxData      (void);
static void GetI2CData      (void);
static BOOL CheckBindButton (void);
static BOOL CheckWakeButton (void);
static void Calibrate_ILO   (void);
static void blinkRedLed     (WORD delayCount);


// ---------------------------------------------------------------------------
//
// main() - Powerup entry
//
// ---------------------------------------------------------------------------
void main(void)
{
    CYFISNP_PROT_STATE eProtStateOld;

    LED_RED_OFF;
    LED_GRN_ON;

    M8C_EnableGInt;

#if (defined DEBUG) || (defined CYFISNP_DEBUG)
    TX8_Start(TX8_PARITY_NONE);
#endif

    CYFISNP_Start();
    // --------------------------------------------------------
    // Disable SNP_Radio Power Management Unit (saves about 32uA)
    // --------------------------------------------------------
    CYFISNP_Write(CYFISNP_PWR_CTRL_ADR,
                  (CYFISNP_Read(CYFISNP_PWR_CTRL_ADR) & ~CYFISNP_PMU_EN) | CYFISNP_PMU_MODE_FORCE);

    LED_GRN_OFF;

    CYFISNP_TimeSet(&oneSecTimer, sleepTicksPerSec);

    I2C_Start();
    I2C_EnableMstr();
    I2C_EnableInt();

    // -----------------------------------------------------------------------
    // POLLING LOOP
    // -----------------------------------------------------------------------
    for (;;)
    {
        // -------------------------------------------------------------------
        // Watch Start Binding Button activity
        // -------------------------------------------------------------------
        if (CheckBindButton())
        {
            CYFISNP_BindStart(ON_THE_FLY_DEV_ID);
            LED_GRN_ON;
        }

        // -------------------------------------------------------------------
        // Watch "Force New Report" button
        // -------------------------------------------------------------------
        if (CheckWakeButton())
        {
            sendNewTxMsg();
        }

        // -------------------------------------------------------------------
        // Run SNP less frequently to save energy
        // -------------------------------------------------------------------
        if (--snpRunScaler == 0)
        {
            snpRunScaler = SNP_RUN_SCALER;
            CYFISNP_Run();          // Poll SNP machine
        }

        // -------------------------------------------------------------------
        // Process received SNP data packets
        //  (only supports update report rate for now)
        // -------------------------------------------------------------------
        if (CYFISNP_RxDataPend() == TRUE)
        {
            CYFISNP_API_PKT *pRxApiPkt;
            pRxApiPkt = CYFISNP_RxDataGet();
            reportTimeSec = pRxApiPkt->payload[0];    // Update report rate
            CYFISNP_RxDataRelease();
        }

        // -------------------------------------------------------------------
        // Periodic 1 sec events
        // -------------------------------------------------------------------
        if (CYFISNP_TimeExpired(&oneSecTimer) == TRUE)
        {
            CYFISNP_TimeSet(&oneSecTimer, sleepTicksPerSec);

            // ---------------------------------------------------------------
            // Blink Heartbeat LED
            // ---------------------------------------------------------------
            if (--ledHeartbeatSec == 0)
            {
                ledHeartbeatSec = LED_HEARTBEAT_SEC;
                blinkRedLed(50);           // *100 uS ON
                Calibrate_ILO();        // Calibrate ILO against IMO
            }

            // ---------------------------------------------------------------
            // If SNP reconnect timeout, then try to reconnect.
            //    (If very power sensitive, may want to defer for 5 minutes)
            // ---------------------------------------------------------------
            if (CYFISNP_eProtState == CYFISNP_CON_MODE_TIMEOUT)
            {
                CYFISNP_Jog();
            }

            // ---------------------------------------------------------------
            // Periodic weather station report
            // ---------------------------------------------------------------
            if (--reportTimerSec == 0)
            {
                reportTimerSec = reportTimeSec;
                sendNewTxMsg();
            }
        }

        // -------------------------------------------------------------------
        // Sleep PSoC until next Sleep Timer interrupt to conserve energy
        // -------------------------------------------------------------------
#if LOW_POWER_TEST
        M8C_Sleep;
#endif

        // -------------------------------------------------------------------
        // Turn OFF Green LED when not in Bind Mode
        // -------------------------------------------------------------------
        if (CYFISNP_eProtState != CYFISNP_BIND_MODE)
        {
            LED_GRN_OFF;
        }
        LED_RED_OFF;        // RED LED always goes OFF
    }
}

static void blinkRedLed(WORD delayCount)
{
    LED_RED_ON;
    while (delayCount != 0)
    {
        CYFISNP_Delay100uS();       // Get good short delays
        --delayCount;
    }
    LED_RED_OFF;
}


// ---------------------------------------------------------------------------
//
// loadTxData()
//
// ---------------------------------------------------------------------------
static void loadTxData(void)
{
    char ivar;

    for (ivar=0; ivar < I2C_PAYLOAD_MAX; ++ivar)
    {
        txApiPkt.payload[ivar] = rxBuffer[ivar];
    }
}

// ---------------------------------------------------------------------------
//
// sendNewTxMsg() - Send a weather station report to the HUB
//
// ---------------------------------------------------------------------------
#define TX_PACKET_LENGTH    8
#define TX_PACKET_TYPE      CYFISNP_API_TYPE_CONF
static void sendNewTxMsg(void)
{
    if (CYFISNP_eProtState == CYFISNP_DATA_MODE
        && CYFISNP_TxDataPend() == FALSE)
    {
        GetI2CData();

        loadTxData();
        txApiPkt.length = TX_PACKET_LENGTH;
        txApiPkt.type   = TX_PACKET_TYPE;
        CYFISNP_TxDataPut(&txApiPkt);
        LED_GRN_ON;
    }
}



// ---------------------------------------------------------------------------
//
// GetI2CData() - Get data from I2C device on P1 (weather station board)
//
// ---------------------------------------------------------------------------
static void GetI2CData(void)
{
    WORD dataDelay;

    // Delay (with timeout), for weather station to be ready.
    ChipSelect_ON;
    CYFISNP_TimeSet(&dataDelay, DATA_READY_TIME);
    while (!CYFISNP_TimeExpired(&dataDelay) && !IS_DataReady_ON);

    // Start the I2C read
    I2C_fReadBytes(SLAVE_ADDRESS, rxBuffer, 8, I2C_CompleteXfer);

    // Wait for I2C to complete
    while ((I2C_bReadI2CStatus()&I2CHW_RD_COMPLETE) == FALSE)
        ;

    I2C_ClrRdStatus();

    ChipSelect_OFF;
}


// ---------------------------------------------------------------------------
//
// Calibrate_ILO() - Calibrate Int Low Freq Osc against the Int Main Osc
//
// ---------------------------------------------------------------------------
static void Calibrate_ILO(void)
{
    WORD bCount;

    // -----------------------------------------------------------------------
    // Get number of ILO ticks in 1 mS (as measured by IMO)
    // -----------------------------------------------------------------------
    Timer8_WritePeriod(255);
    M8C_DisableGInt;
    Timer8_Start();
    for (bCount=0; bCount != 10; ++bCount)
    {
        CYFISNP_Delay100uS();
    }
    bCount = Timer8_bReadTimer();
    bCount = 255 - bCount;
    Timer8_Stop();
    M8C_EnableGInt;

    sleepTicksPerSec = bCount<<1;   // Start by assuming ILO(wake) = ILO(sleep)

    // -----------------------------------------------------------------------
    // Without ILO in HighBias mode (See ILO_TR register in TRM), the ILO
    //  operates FASTER awake than asleep.
    // Therefore approximate ILO(sleep) as 25% lower than ILO(wake).
    // -----------------------------------------------------------------------
    sleepTicksPerSec -= bCount>>1;  // Decrease by 25% to estimate ILO(sleep)
}



// ---------------------------------------------------------------------------
//
// bindButtonIsOn()
//
// ---------------------------------------------------------------------------
static BOOL bindButtonIsOn(void)
{
    SW1_Data_ADDR &= ~SW1_MASK;                  // Ensure GPIO pulldown active
    return(SW1_Data_ADDR & SW1_MASK);
}

// ---------------------------------------------------------------------------
//
// CheckBindButton()
//
// ---------------------------------------------------------------------------
static BOOL CheckBindButton(void)
{
    WORD lvDelay;
    if (bindButtonIsOn())
    {
        CYFISNP_TimeSet(&lvDelay, DEBOUNCE_TIME);       // Debouncing, delay
        while (CYFISNP_TimeExpired(&lvDelay) == 0) ;    // WAIT
        if (bindButtonIsOn())           // If button still ON
        {
            while (bindButtonIsOn())    // Wait for button release
            {
                M8C_ClearWDTAndSleep;
#if LOW_POWER_TEST
                M8C_Sleep;
#endif
            }
            return(TRUE);
        }
    }
    return(FALSE);
}


// ---------------------------------------------------------------------------
//
// buttonIncReportTime() - Manually step report interval
//
// ---------------------------------------------------------------------------
static const WORD reportTimes[] = {1, 5, 30, 60, 300};  // in Seconds
static char       reportTimesIdx = 1;                   // Start at 5 sec
#define REPORT_TIMES_MAX   (sizeof(reportTimes)/2)      // # entries

static void buttonIncReportTime(void)
{
    if (++reportTimesIdx >= REPORT_TIMES_MAX)
    {
        reportTimesIdx = 0;
    }
    reportTimeSec = reportTimes[reportTimesIdx];
    reportTimerSec = reportTimeSec;
}

// ---------------------------------------------------------------------------
//
//  showReportDelay() - Pulse LED to show INDEX of new report delay
//
// ---------------------------------------------------------------------------
static void showReportDelay(void)
{
#define HI_LO_PULSE   10    // Hi or Lo pulse width (in Sleep intervals)
    char pulseCt = reportTimesIdx + 1;  // 1st entry [0] gives 1 pulse
    char wait;

    LED_RED_OFF;
    for (wait=HI_LO_PULSE; wait != 0; --wait)
    {
#if LOW_POWER_TEST
        M8C_Sleep;
#endif
    }

    while (pulseCt-- != 0)
    {
        LED_RED_ON;
        for (wait=HI_LO_PULSE; wait != 0; --wait)
        {
#if LOW_POWER_TEST
            M8C_Sleep;
#endif
        }
        LED_RED_OFF;
        for (wait=HI_LO_PULSE; wait != 0; --wait)
        {
#if LOW_POWER_TEST
            M8C_Sleep;
#endif
        }
    }
    ledHeartbeatSec = LED_HEARTBEAT_SEC;    // Suppress next heartbeat pulse
}


// ---------------------------------------------------------------------------
//
// wakeButtonIsOn()
//
// ---------------------------------------------------------------------------
static BOOL wakeButtonIsOn(void)
{
    SW2_Data_ADDR &= ~SW2_MASK;              // Ensure GPIO pulldown active
    return(SW2_Data_ADDR & SW2_MASK);
}
// ---------------------------------------------------------------------------
//
// CheckWakeButton() - Also cyclic steps report rate if is button held.
//
// ---------------------------------------------------------------------------

#define BUTTON_HOLD_TIME_TO_INC_REPORT_DELAY   (1500/CYFISNP_TIMER_UNITS)

static BOOL CheckWakeButton(void)
{
    WORD lvDelay;
    WORD reportDly;

    BOOL reportDlySet;

    if (wakeButtonIsOn())
    {
        CYFISNP_TimeSet(&lvDelay, DEBOUNCE_TIME);       // Debouncing, delay
        while (CYFISNP_TimeExpired(&lvDelay) == 0) ;    // WAIT
        if (wakeButtonIsOn())           // If button still ON
        {
            CYFISNP_TimeSet(&reportDly, BUTTON_HOLD_TIME_TO_INC_REPORT_DELAY);
            reportDlySet = TRUE;
            while (wakeButtonIsOn())    // Wait for button release
            {
                if (CYFISNP_TimeExpired(&reportDly) == TRUE
                    && reportDlySet == TRUE)
                {
                    reportDlySet = FALSE;
                    buttonIncReportTime();
                    LED_RED_ON;             // Keep LED ON while switch held
                }
                M8C_ClearWDTAndSleep;
#if LOW_POWER_TEST
                M8C_Sleep;
#endif

            }
            if (reportDlySet == FALSE)
            {
                showReportDelay();
            }
            return(TRUE);
        }
    }
    return(FALSE);
}

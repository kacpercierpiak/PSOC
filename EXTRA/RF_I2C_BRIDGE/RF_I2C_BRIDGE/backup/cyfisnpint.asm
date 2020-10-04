;;*****************************************************************************
;;*****************************************************************************
;;  FILENAME: CYFISNPINT.asm
;;  Version: 2.00, Updated on 2011/6/28 at 6:7:54
;;  Generated by PSoC Designer 5.1.2306
;;
;;  DESCRIPTION: <NODE> Star Network Protocol,  CYFISNP IRQ processing
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2011. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

include "m8c.inc"
include "memory.inc"
include "psocgpioint.inc"
include "CYFISNP.inc"

; ----------------------------------------------------------------------------
;
; RAM Allocation
;
; ----------------------------------------------------------------------------
AREA    InterruptRAM(ram)       ; Variables on RAM Page 0

 SleepTimer_TickCount::
_SleepTimer_TickCount::    BLK  2


AREA UserModules (ROM, REL)

CYFISNP_ST_64_HZ:      equ 0x08
CYFISNP_ST_CLOCK_MASK: equ 0x18

.SECTION
 CYFISNP_SleepTimer_Set64Hz::
_CYFISNP_SleepTimer_Set64Hz::
   RAM_PROLOGUE RAM_USE_CLASS_1
   M8C_SetBank1
   mov  A, reg[OSC_CR0]                      ; Get current timer value
   and  A, ~CYFISNP_ST_CLOCK_MASK   ; Zero out old timer value
   or   A, CYFISNP_ST_64_HZ         ; Set new timer values
   mov  reg[OSC_CR0],A                       ; Write it
   M8C_SetBank0
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret
.ENDSECTION


_CYFISNP_SLEEP_ISR::
   inc  [SleepTimer_TickCount+1]
   jnc  CYFISNP_SLEEP_ISR_END
   inc  [SleepTimer_TickCount+0]
CYFISNP_SLEEP_ISR_END:
      reti



_CYFISNP_ISR::
_CYFISNP_IRQ_Pin_Hidden_INT::
_CYFISNP__IRQ_INT::

   reti

;----------------------------------------------------------------------------
;
; CYFISNP_Delay100uS - Delay loop for 100 uS
;
; void    CYFISNP_Delay100uS  (void);
;----------------------------------------------------------------------------
CPU_CLK_DELAY:  EQU     (4 * 0xc)
_CYFISNP_Delay100uS::
 CYFISNP_Delay100uS::
.L0:    MOV     X, CPU_CLK_DELAY
.L1:    DEC     X               ;  4 cycles
        NOP                     ;  4 cycles
        NOP                     ;  4 cycles
        NOP                     ;  4 cycles
        NOP                     ;  4 cycles
        JNZ     .L1             ;  5 cycles
                                ; 25 cycles = 2.08333 uS @ 12MHz
        RET



;----------------------------------------------------------------------------
;
; 64 Byte NODE FLASH RECORD AREA
;
;----------------------------------------------------------------------------

CYFISNP_EEP_PHY_ADR:   equ (0xff * 0x40)
                area    ReservedFlashBlock(ROM,ABS,CON)
					 org     CYFISNP_EEP_PHY_ADR
 _CYFISNP_EEP_PHY_ADR::
                db      0, 0, 0, 0, 0, 0, 0, 0
                db      0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30
                db      0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30
                db      0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30
                db      0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30
                db      0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30
                db      0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30
                db      0x30,0x30,0x30,0x30,0x30,0x30,0x30,0x30

; ############################################################################

;;*****************************************************************************
;;*****************************************************************************
;;  ADC10INT.asm
;;  Version: 1.30, Updated on 2015/3/4 at 22:21:20
;;  Generated by PSoC Designer 5.4.3191
;;
;;  DESCRIPTION: ADC10 User Module ISR implementation file.
;;*****************************************************************************
;;*****************************************************************************

include "m8c.inc"
include "memory.inc"
include "ADC10.inc"

export _ADC10_ADC_ISR
export _ADC10_CNT_ISR

export  ADC10_bTempMSB
export _ADC10_iResult
export  ADC10_iResult
export _ADC10_bfStatus
export  ADC10_bfStatus

AREA InterruptRAM (RAM, REL)
   ADC10_bTempMSB:      BLK   1
  _ADC10_iResult:
   ADC10_iResult:       BLK   2  ;A/D value
  _ADC10_bfStatus:
   ADC10_bfStatus:      BLK   1  ;Data Valid Flag
AREA UserModules (ROM, REL)

_ADC10_ADC_ISR:
; ISR ,including jmptable takes 156 cpu cycles.)
   tst  reg[ADC10_CNTClrIntReg],ADC10_CNTMask
   jz NoPendingInterrupt;  Make sure counter has been serviced
   inc  [ADC10_bTempMSB]
   and  reg[ADC10_CNTClrIntReg],~(ADC10_CNTMask)
NoPendingInterrupt:
   push A
   tst  reg[ADC10_ADC_CR],80h
   jz   .InRange

; Read Counter
.OverRange:
   mov  [ADC10_iResult],ffh
   mov  [ADC10_iResult + 1],ffh
   jmp  .Done

.InRange:
   mov  [ADC10_iResult],[ADC10_bTempMSB]
   mov  A,reg[ADC10_CNT_DR0]
   mov  A,reg[ADC10_CNT_DR2]   ;A contains next prev value
   cpl  A
   mov  [ADC10_iResult+1],A
.Done:
   and  reg[ADC10_CNT_CR0], ~ADC10_ON 
   mov  reg[ADC10_CNT_DR1], 0xFF
   or   reg[ADC10_CNT_CR0], ADC10_ON

   mov  [ADC10_bfStatus],01h
   mov  [ADC10_bTempMSB], 00h

   ;@PSoC_UserCode_BODY_1@ (Do not change this line.)
   ;---------------------------------------------------
   ; Insert your custom assembly code below this banner
   ;---------------------------------------------------
   ;   NOTE: interrupt service routines must preserve
   ;   the values of the A and X CPU registers.
   
   ;---------------------------------------------------
   ; Insert your custom assembly code above this banner
   ;---------------------------------------------------
   
   ;---------------------------------------------------
   ; Insert a lcall to a C function below this banner
   ; and un-comment the lines between these banners
   ;---------------------------------------------------
   
   ;PRESERVE_CPU_CONTEXT
   ;lcall _My_C_Function
   ;RESTORE_CPU_CONTEXT
   
   ;---------------------------------------------------
   ; Insert a lcall to a C function above this banner
   ; and un-comment the lines between these banners
   ;---------------------------------------------------
   ;@PSoC_UserCode_END@ (Do not change this line.)

   pop A
   reti

_ADC10_CNT_ISR:
   inc [ADC10_bTempMSB]

   ;@PSoC_UserCode_BODY_2@ (Do not change this line.)
   ;---------------------------------------------------
   ; Insert your custom assembly code below this banner
   ;---------------------------------------------------
   ;   NOTE: interrupt service routines must preserve
   ;   the values of the A and X CPU registers.
   
   ;---------------------------------------------------
   ; Insert your custom assembly code above this banner
   ;---------------------------------------------------
   
   ;---------------------------------------------------
   ; Insert a lcall to a C function below this banner
   ; and un-comment the lines between these banners
   ;---------------------------------------------------
   
   ;PRESERVE_CPU_CONTEXT
   ;lcall _My_C_Function
   ;RESTORE_CPU_CONTEXT
   
   ;---------------------------------------------------
   ; Insert a lcall to a C function above this banner
   ; and un-comment the lines between these banners
   ;---------------------------------------------------
   ;@PSoC_UserCode_END@ (Do not change this line.)
   reti

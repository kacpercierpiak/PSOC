;;*****************************************************************************
;;*****************************************************************************
;;  ADC10.asm
;;  Version: 1.1, Updated on 2011/6/28 at 6:7:55
;;  Generated by PSoC Designer 5.4.3191
;;
;;  DESCRIPTION: ADC10 User Module software implementation file.
;;*****************************************************************************
;;*****************************************************************************

include "m8c.inc"
include "memory.inc"
include "ADC10.inc"
;-----------------------------------------------
;  Global Symbols
;-----------------------------------------------

export _ADC10_Start
export  ADC10_Start
export _ADC10_Stop
export  ADC10_Stop
export _ADC10_StartADC
export  ADC10_StartADC
export _ADC10_StopADC
export  ADC10_StopADC
export _ADC10_fIsDataAvailable
export  ADC10_fIsDataAvailable
export _ADC10_iGetData
export  ADC10_iGetData
export _ADC10_ClearFlag
export  ADC10_ClearFlag
export _ADC10_iGetDataClearFlag
export  ADC10_iGetDataClearFlag
export _ADC10_iCal
export  ADC10_iCal

AREA UserModules (ROM, REL)
.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC10_Start
;
;  DESCRIPTION:
;  Applies power setting to the module's analog blocks
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:  A:= Range Informatio
;
;  RETURNS:    Nothing
;
;-----------------------------------------------------------------------------
 ADC10_Start:
_ADC10_Start:
   RAM_PROLOGUE RAM_USE_CLASS_1
//Turn on Power to analog block
   mov   reg[ADC10_ACE_CR2],A
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This code check to see if the Column clock should be set to SysClk Direct
   M8C_SetBank1
      tst  reg[ADC10_CNT_OUT],80h
      jz   SkipSetClock
      or   reg[6Bh], ((ADC10_ACE_CR1 - 72h)* 0fh)+ 04h
   SkipSetClock:
   M8C_SetBank0
   mov   reg[CMP_CR0],(((ADC10_ACE_CR1 -72h)/4)*11h)+11h;specify column interrupt
   mov   reg[DEC_CR0],(((ADC10_ACE_CR1 -72h)/4)*11h)+11h;gate the comp1

   mov   reg[PWM_CR], (PWM_High+PWM_Low)
//Turn on Power to ADC Control
   or    reg[ADC10_ADC_CR], ADC10_ON

   RAM_EPILOGUE RAM_USE_CLASS_1
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC10_Stop
;
;  DESCRIPTION:
;  Removes power setting to the module's analog blocks.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: None
;
;  RETURNS:   Nothing
;
;-----------------------------------------------------------------------------
 ADC10_Stop:
_ADC10_Stop:
   RAM_PROLOGUE RAM_USE_CLASS_1
//Turn off Power to analog block
   and   reg[ADC10_ACE_CR2],~ADC10_ON
//Turn off Power to ADC Control
   and   reg[ADC10_ADC_CR], ~ADC10_ON
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   M8C_SetBank1
      tst  reg[ADC10_CNT_OUT],80h
      jz   SkipClearClock
      and  reg[6Bh], ~(((ADC10_ACE_CR1 - 72h)* 0fh)+ 04h)
   SkipClearClock:
   M8C_SetBank0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC10_StartADC
;
;  DESCRIPTION:
;  Starts the A/D convertor
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: None
;
;  RETURNS:   Nothing
;
;-----------------------------------------------------------------------------
 ADC10_StartADC:
_ADC10_StartADC:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >(ADC10_iResult)
   call ADC10_StopADC
   mov  reg[ADC10_CNT_DR1],ffh ;reload Counter
   mov  [ADC10_bTempMSB],00h
; enable interupt

   and   reg[ADC10_ADCClrIntReg],~ADC10_ADCMask ;Clear ACol1 interrupt
   or    reg[ADC10_ADCIntReg],ADC10_ADCMask     ;Enable ACol1 interrupt

   and   reg[ADC10_CNTClrIntReg],~ADC10_CNTMask ;Clear Counter interrupt
   or    reg[ADC10_CNTIntReg],ADC10_CNTMask     ;Enable Counter interrupt
   mov   [ADC10_bfStatus],0
   or   reg[ADC10_CNT_CR0],01h ;start counter

; Start PWM
   or    reg[PWM_CR],01h
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC10_StopAD
;
;  DESCRIPTION:
;  Completely shuts down the A/D is an orderly manner.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:  None
;
;  RETURNS:    Nothing
;-----------------------------------------------------------------------------
 ADC10_StopADC:
_ADC10_StopADC:
   RAM_PROLOGUE RAM_USE_CLASS_1
; turn off pwm
   and   reg[PWM_CR],~01h
; disable interupt
   and   reg[ADC10_ADCIntReg],~ADC10_ADCMask  ;enable ACol1 interrupt

; clr interrupt
   and   reg[INT_CLR0],~ADC10_ADCMask  ;clear residue ACol1 interrupt

; stop counter
   and  reg[ADC10_CNT_CR0],~ADC10_ON      ;stop counter
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC10_fIsDataAvailable
;
;  DESCRIPTION:
;  Returns the status of the Data Available flag
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: None
;
;  RETURNS:
;  A  Returns data status  A == 0 no data available
;                          A != 0 data available
;
;-----------------------------------------------------------------------------
 ADC10_fIsDataAvailable:
_ADC10_fIsDataAvailable:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >(ADC10_iResult)
   mov   A,[ADC10_bfStatus]                     ; Get status byte
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC10_iGetDataClearFlag
;  FUNCTION NAME: ADC10_iGetData
;
;  DESCRIPTION:
;  Returns the data from the A/D.  Does not check if data is available.
;  bGetDataClearFlag clears the result ready flag as well.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: None
;
;  RETURNS:  X,A The ADC result.
;
;-----------------------------------------------------------------------------
 ADC10_iGetDataClearFlag:
_ADC10_iGetDataClearFlag:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >(ADC10_iResult)
   mov   [ADC10_bfStatus],0
 ADC10_iGetData:
_ADC10_iGetData:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >(ADC10_iResult)
   and   reg[ADC10_ADCIntReg],~ADC10_ADCMask ; Prevent Result modification during reading
   mov   X,[ADC10_iResult]
   mov   A,[ADC10_iResult+1]
   or    reg[ADC10_ADCIntReg],ADC10_ADCMask
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC10_ClearFlag
;
;  DESCRIPTION:
;  Clears the data ready flag.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: None
;
;  RETURNS:   Nothing
;
;------------------------------------------------------------------------
 ADC10_ClearFlag:
_ADC10_ClearFlag:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >(ADC10_iResult)
   mov   [_ADC10_bfStatus],0
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC10_iCal
;
;  DESCRIPTION:
;  Adjusts the trim till the ADC value matchs the argument value.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: Desired Cal Value (int) , Reference Selection (BYTE)
;
;  RETURNS: X,A  Closest Value to Desired Value
;
;-----------------------------------------------------------------------------

RefSelect:        equ -5
Toggle:           equ -5
Desired_MSB:      equ -4
Desired_LSB:      equ -3
;2 reserved for PC
ClosestMSB:       equ 0
ClosestLSB:       equ 1

PMux_Save:        equ  2
AMux_Save:        equ  3
ABF_Save:         equ  4

ADC10_iCal:
_ADC10_iCal:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >(ADC10_iResult)
   RAM_PROLOGUE RAM_USE_CLASS_2
   mov   X,SP
   mov   A,0
   push  A                                ;Place Closest MSB on Stack
   push  A                                ;Place ClosestLSB  on Stack

   mov  A, reg[ADC10_ACE_CR1]
   push A                                 ;Place PMux_Save on stack

   mov  A, reg[AMX_IN]                    ;Place orginal AMX_IN on Stack
   push A

   M8C_SetBank1
      mov  A, reg[ABF_CR0]                ;Place Orginal ABF_CR on Stack
   M8C_SetBank0
   push A

   call SetInput                          ;Set the input to desired reference source

   M8C_SetBank1
   mov  reg[ADC10_ADC_TR],00h  ;Set Cap for Largest Value
   M8C_SetBank0

   mov  [X + Toggle],80h

.Repeat: ;repeat
   M8C_SetBank1
   mov  A,reg[ADC10_ADC_TR]
   xor  A,[X + Toggle] ; toggle trim
   mov  reg[ADC10_ADC_TR],A
   M8C_SetBank0

   call ADC10_StartADC ; readADC

.GetData:
   tst  [ADC10_bfStatus],ffh
   jz   .GetData

   mov  A,[ADC10_iResult]
   cmp  A,[X + Desired_MSB]
   jc   .LessThan
   jnz  .MoreThan

   mov  A,[ADC10_iResult+1]
   cmp  A,[X + Desired_LSB]
   jc   .LessThan
   jnz  .MoreThan

.IsEqual: ; ADC = Desired
   mov   A, [ADC10_iResult+1]
   mov   [X +ClosestLSB],A
   mov   A, [ADC10_iResult]
   mov   [X + ClosestMSB],A
   jmp   .Done
.LessThan: ; else ADC < Desired (Cap is too small)
   M8C_SetBank1
      mov  A,reg[ADC10_ADC_TR]
      xor  A,[X + Toggle] ; toggle trim
      mov  reg[ADC10_ADC_TR],A
   M8C_SetBank0
   jmp  .AllDone
.MoreThan: ; ADC > Desired:
   mov   A, [ADC10_iResult+1]
   mov   [X +ClosestLSB],A
   mov   A, [ADC10_iResult]
   mov   [X + ClosestMSB],A

.AllDone:
   add  A,0 ; toggle = toggle/2
   rrc  [X+ Toggle]
.Until:
   jnz  .Repeat ;until toggle is done

.Done:
   call ADC10_StopADC ;return( Closest)
   pop  A
      M8C_SetBank1
   mov  reg[ABF_CR0], A                               ;restore original  ABF_CR0
   M8C_SetBank0

   pop  A
   mov  reg[AMX_IN],A                                 ;restore orginal   AMX_IN

   pop  A
   mov  reg[ADC10_ACE_CR1], A			;restore original value of ACE_CR1

   pop  A                                             ;return(ClosestLSB)
   pop  X                                             ;return(ClosestMSB)
   RAM_EPILOGUE RAM_USE_CLASS_2
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret

SetInput:
   mov   A, reg[ADC10_ACE_CR1]
   and   A,~07h
   tst   [X + RefSelect],10h
   jnz   .PortInput

.PMuxConnection:
   or    A, [X + RefSelect]
   mov   reg[ADC10_ACE_CR1], A           ;Connect to Vbg or AMux
   ret

.PortInput:
   or   A,01h
   mov   reg[ADC10_ACE_CR1], A           ;set for input mux

   mov   A,ADC10_ACE_CR1
   and   A , 04h
   jz    .Column0
.Column1:
   tst   [X + RefSelect],0h                           ;check if even or odd pin
   jnz   .OddPin
.EvenPin:
   and   [X + RefSelect],0ch
   mov   A,reg[AMX_IN]
   and   A,~0ch
   or    A,[X + RefSelect]
   mov   reg[AMX_IN],A
   ret
.OddPin:
   M8C_SetBank1
      or  reg[ABF_CR0],80h                          ;set for columnzero mux
   M8C_SetBank0
.Column0:
   and   [X + RefSelect],03h
   mov   A,reg[AMX_IN]
   and   A,~03h
   or    A,[X + RefSelect]
   mov   reg[AMX_IN],A
   ret
.ENDSECTION

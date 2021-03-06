;;*****************************************************************************
;;*****************************************************************************
;;  ADC10.asm
;;  Version: 1.30, Updated on 2015/3/4 at 22:21:20
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

IF ADC10_DIE_TEMP_ENABLED
export  ADC10_StartTempMeasurement
export _ADC10_StartTempMeasurement
export  ADC10_GetTemperature
export _ADC10_GetTemperature

AREA InterruptRAM (RAM, REL)
  ADC10_wCalibrationCount:  BLK   2  ;CalibrationCount value
  ADC10_bADCInput:          BLK   1  ; ADC Input
ENDIF   

AREA UserModules (ROM, REL)

LSB:  equ  1
MSB:  equ  0

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
;Turn on Power to analog block
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
;Turn on Power to ADC Control
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
;Turn off Power to analog block
   and   reg[ADC10_ACE_CR2],~ADC10_ON
;Turn off Power to ADC Control
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

   M8C_ClearIntFlag ADC10_ADCClrIntReg, ADC10_ADCMask   ;Clear ACol1 interrupt
   M8C_EnableIntMask ADC10_ADCIntReg, ADC10_ADCMask     ;Enable ACol1 interrupt

   M8C_ClearIntFlag ADC10_CNTClrIntReg, ADC10_CNTMask   ;Clear Counter interrupt
   M8C_EnableIntMask ADC10_CNTIntReg, ADC10_CNTMask     ;Enable Counter interrupt
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
   M8C_DisableIntMask ADC10_ADCIntReg, ADC10_ADCMask  ;disable ACol1 interrupt

; clr interrupt
   M8C_ClearIntFlag INT_CLR0, ADC10_ADCMask  ;clear residue ACol1 interrupt

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
   M8C_DisableIntMask ADC10_ADCIntReg, ADC10_ADCMask ; Prevent Result modification during reading
   mov   X,[ADC10_iResult]
   mov   A,[ADC10_iResult+1]
   M8C_EnableIntMask ADC10_ADCIntReg, ADC10_ADCMask
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

IF ADC10_DIE_TEMP_ENABLED
  mov A, [X + Desired_MSB]
  mov [ADC10_wCalibrationCount+MSB],A
  mov A, [X + Desired_LSB]
  mov [ADC10_wCalibrationCount+LSB],A
ENDIF

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

IF ADC10_DIE_TEMP_ENABLED
.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC10_StartTempMeasurement
;
;  DESCRIPTION: Sets VTemp as ADC input and starts ADC meaurement
;
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: None
;
;  RETURNS:   Nothing
;
;-----------------------------------------------------------------------------
 ADC10_StartTempMeasurement:
_ADC10_StartTempMeasurement:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >(ADC10_bADCInput) 
    M8C_SetBank0
    
    mov A, reg[ADC10_ACE_CR1]
    and A, ADC10_VTEMP_INPUT   ; Mask VTemp input bits
    mov [ADC10_bADCInput], A ; Store the ADC Input
    
    and  reg[ADC10_ACE_CR1], ~ADC10_VTEMP_INPUT ; Set VTemp as ADC Input
    call ADC10_StartADC
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC10_GetTemperature
;
;  DESCRIPTION: Read voltage on the internal VTemp sensor and calculate Temperature 
;   by using the following equations:
;   V[mV] = wADC_Result * wCalibrationVoltage[mV] / wCalibrationCount;
;   T = (COEFFICIENT_M*V[mV])/1000 - COEFFICIENT_B.
;   wADC_Result � result of the ADC VTemp voltage measurement
;   wCalibrationVoltage � Input parameter;
;   wCalibrationCount � stored value of the wVal parameter of the ADC10_ wCal(WORD wVal) API function.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: A,X  Calibration Voltage (in the mV units) that was used for the ADC calibration
;
;  RETURNS:   A    Die Temperature in the Celsius degrees
;
;-----------------------------------------------------------------------------

TEMP_0:   equ 0           ; MSB of a temporary data
TEMP_1:   equ 1          
TEMP_2:   equ 2          
TEMP_3:   equ 3           ; LSB of a temporary data
 
 ADC10_GetTemperature:
_ADC10_GetTemperature:
   RAM_PROLOGUE RAM_USE_CLASS_2
   M8C_SetBank0
   RAM_SETPAGE_CUR >(ADC10_bfStatus) 

   push X       ; Save MSB of the ADC10_wCalibrationVoltage
   push A       ; Save LSB of the ADC10_wCalibrationVoltage   
   
   call ADC10_StopADC         ; Temp Measurement is one-shot operation
   
   mov  X, SP   ; Save the SP in the X
   dec X 
   dec X

   add SP, 2    ; Reserve the four bytes Temp Buffer in the Stack
    
   M8C_SetBank0 
   ;
   ;  Convert ADC Counts into Voltage
   ;
   ;calculate : Var = ADC10_iGetData * ADC10_iCalibrationVoltage
   
IF SYSTEM_LARGE_MEMORY_MODEL         ; Get the MSB of the pointer
   mov  A, reg[STK_PP]             
ELSE    
   mov  A, 0
ENDIF   
   push A
   push X                            ; Get the LSB of the pointer
   mov  A, [X+TEMP_0]                ; MSB of the ADC10_iCalibrationVoltage
   push A
   mov  A, [X+TEMP_1]                ; LSB of the ADC10_iCalibrationVoltage
   push A

   mov   A,[ADC10_iResult+MSB]   ; MSB of the ADC10_iGetData
   push  A
   mov   A,[ADC10_iResult+LSB] ; LSB of the ADC10_iGetData
   push  A
   lcall ADC10_mulu_16x16_32 ; do the converting   
   add SP, 250 ; pop the stack
   
   mov  X, SP
   swap A, X
   sub  A, 4
   swap A, X    ; Save the SP in the X
   push X       ; Save the SP in the Stack
   
   ;calculate : Var = Var / ADC10_wCalibrationCount

IF SYSTEM_LARGE_MEMORY_MODEL         ; Get the MSB of the pointer
   mov  A, reg[STK_PP]             
ELSE    
   mov  A, 0
ENDIF   
   push A
   push X                            ; Get the LSB of the pointer
   mov  A, 0                 ; push the ADC10_wCalibrationCount
   push A
   push A
   mov  A, [ADC10_wCalibrationCount+MSB]
   push A
   mov  A, [ADC10_wCalibrationCount+LSB]
   push A
   mov  A, [X+TEMP_0] ; push the Var
   push A
   mov  A, [X+TEMP_1] 
   push A
   mov  A, [X+TEMP_2]
   push A
   mov  A, [X+TEMP_3] 
   push A   
   lcall ADC10_divu_32x32_32 ; do the application   
   add SP, 246 ; pop the stack
   
   pop X 
   push X
   ;
   ;  Convert Voltage into Temperature;
   ;  T = ADC10_COEFFICIENT_M*V/1000 - ADC10_COEFFICIENT_B
   ;   
   ;   multiplication
IF SYSTEM_LARGE_MEMORY_MODEL         ; Get the MSB of the pointer
   mov  A, reg[STK_PP]             
ELSE    
   mov  A, 0
ENDIF   
   push A
   push X                            ; Get the LSB of the pointer
   mov  A, [X+TEMP_2] ; push the Var
   push A
   mov  A, [X+TEMP_3]
   push A
   mov  A, >ADC10_COEFFICIENT_M ; push the COEFFICIENT_M
   push A
   mov  A, <ADC10_COEFFICIENT_M
   push A
   lcall ADC10_mulu_16x16_32 ; do the converting 
   add SP, 250 ; pop the stack
   
   pop  X
   push X
   
   ; division
IF SYSTEM_LARGE_MEMORY_MODEL         ; Get the MSB of the pointer
   mov  A, reg[STK_PP]             
ELSE    
   mov  A, 0
ENDIF   
   push A
   push X                            ; Get the LSB of the pointer
   mov  A, 0                 ; push the 1000
   push A
   push A
   mov  A, >1000
   push A
   mov  A, <1000
   push A
   mov  A, [X+TEMP_0] ; push the Var
   push A
   mov  A, [X+TEMP_1] 
   push A
   mov  A, [X+TEMP_2]
   push A
   mov  A, [X+TEMP_3] 
   push A    
   lcall ADC10_divu_32x32_32 ; do the application                 // DD
   add SP, 246 ; pop the stack   

   pop  X
   
   ; restore the ADC input
   mov A, reg[ADC10_ACE_CR1]
   and A, ~ADC10_VTEMP_INPUT
   or  A, [ADC10_bADCInput] ; Restore the ADC Input   
   mov reg[ADC10_ACE_CR1], A 
   
   ;subtraction
   mov  A, [X+TEMP_3] 
   sub  A, <ADC10_COEFFICIENT_B
   
   add  SP, 252
   mov   [ADC10_bfStatus], 0  ; Clear the DataReady Flag
   
   RAM_EPILOGUE RAM_USE_CLASS_2
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC10_mulu_16x16_32
;
;  DESCRIPTION:  Applies 32-bit unsigned multiple result of two 16-bit unsigned operands
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:
;           wOpr1 (WORD) - first operand in  (MSB)[SP-4][SP-3](LSB)
;           wOpr2 (WORD) - second operand in (MSB)[SP-6][SP-5](LSB)
;
;  RETURNS: 32-bit unsigned result of multiplication by his pointer
;          *dRes (DWORD*) - pointer to result of wOpr1 and wOpr2 multiplication
;                          (MSB)[SP-8][SP-7](LSB)
;
TEMP0:     equ -1           ; temporary data
TEMP1:     equ -2           ; temporary data
COUNTER:   equ -3           ; loop counter
OPR1_LSB:  equ -6           ; first operand LSB
OPR1_MSB:  equ -7           ; first operand MSB
OPR2_LSB:  equ -8           ; second operand LSB
OPR2_MSB:  equ -9           ; second operand LSB
DEST_LSB:  equ -10          ; destination buffer pointer LSB
DEST_MSB:  equ -11          ; destination buffer pointer MSB


 ADC10_mulu_16x16_32:
    ; We do not need to set IDX pointer because ADC10_GetTemperature 
    ; and ADC10_mul_16x16_32 are in the same ram area 
    M8C_SetBank0
    RAM_SETPAGE_CUR >ADC10_bTempMSB
    add   SP, 3               ; create temporary buffer in the Stack         
    mov   X, SP               ; Store SP  
    
    ;beginning multiplication
;      [X+OPR1_MSB][X+OPR1_LSB] - 16-bit unsigned multiplier (first operand)
;      [X+OPR2_MSB][X+OPR2_LSB] - 16-bit unsigned multiplicand (second operand)
    mov   A, 0x00
    mov   [X+TEMP0], A                 ;clear LSB of result
    mov   [X+TEMP1], A                 ;clear MSB of result
    add   A, 0x10                      ;clear CARRY-bit
    mov   [X+COUNTER], A               ;init loop counter
.loop:
    tst   [X+OPR2_LSB], 0x01
    jz    .cont
    mov   A,[X+OPR1_LSB]               ;if [X+OPR1_LSB].0=1 thet result+=first operand
    add   [X+TEMP1], A
    mov   A,[X+OPR1_MSB]
    adc   [X+TEMP0], A
.cont:
    rrc   [X+TEMP0]                    ;1-bit right shift of second operand
    rrc   [X+TEMP1]
    rrc   [X+OPR2_MSB]                 ;1-bit left shift of first operand
    rrc   [X+OPR2_LSB]
    dec   [X+COUNTER]                  ;decrement loop counter
    jnz   .loop    
    
; Multiplication is complete;
; 32-bit unsigned multiplication result is located here:   
;        (MSB)[X+TEMP0][X+TEMP1][X+OPR2_MSB][X+OPR2_LSB](LSB)
    
; copy result to variable pointed by pointer [X+DEST_MSB][X+DEST_LSB]
IF   (SYSTEM_LARGE_MEMORY_MODEL)
    mov   A, [X+DEST_MSB]
    RAM_SETPAGE_MVW A
ENDIF                           ;SYSTEM_LARGE_MEMORY_MODEL
    mov   A, [X+DEST_LSB]
    mov   [ADC10_bfStatus], A
    mov   A, [X+TEMP0]
    mvi   [ADC10_bfStatus], A
    mov   A, [X+TEMP1]
    mvi   [ADC10_bfStatus], A
    mov   A, [X+OPR2_MSB]
    mvi   [ADC10_bfStatus], A
    mov   A, [X+OPR2_LSB]
    mvi   [ADC10_bfStatus], A
    
    add   SP, 253                ;restore Stack pointer
 ret
.ENDSECTION



.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADC10_divu_32x32_32
;
;  DESCRIPTION:
;  Applies 32-bit unsigned result of two 32-bit unsigned operands division
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:
;     dOpr1 (DWORD) - first operand in (MSB)[SP-6][SP-5][SP-4][SP-3](LSB)
;     dOpr2 (DWORD) - second operand in (MSB)[SP-10][SP-9][SP-8][SP-7](LSB)
;
;  RETURNS: 32-bit unsigned result of division dOpr1/dOpr2 by his pointer
;          *dRes (DWORD*) - pointer to result of dOpr1 and dOpr2 division
;                           (MSB)[SP-12][SP-11](LSB)

TEMP0:     equ -1           ; temporary data
TEMP1:     equ -2           ; temporary data
TEMP2:     equ -3           ; temporary data
TEMP3:     equ -4           ; temporary data
COUNTER:   equ -5           ; loop counter
OPR1_0:    equ -8           ; first operand LSB
OPR1_1:    equ -9           ; first operand LSB+1
OPR1_2:    equ -10          ; first operand MSB-1
OPR1_3:    equ -11          ; first operand MSB
OPR2_0:    equ -12          ; second operand LSB
OPR2_1:    equ -13          ; second operand LSB+1
OPR2_2:    equ -14          ; second operand MSB-1
OPR2_3:    equ -15          ; second operand MSB
DEST_LSB:  equ -16          ; destination buffer pointer LSB
DEST_MSB:  equ -17          ; destination buffer pointer MSB

 ADC10_divu_32x32_32:
    ; We do not need to set IDX pointer because ADC10_GetTemperature 
    ; and ADC10_divu_32x32_32 are in the same ram area 
    M8C_SetBank0
    RAM_SETPAGE_CUR >ADC10_bTempMSB
    add   SP, 5               ; create temporary buffer in the Stack         
    mov   X, SP               ; Store SP      

;  ARGUMENTS:
;   (MSB)[X+OPR1_3][X+OPR1_2][X+OPR1_1][X+OPR1_0](LSB) -  first 32-bit unsigned operand of division
;                                                        (dividend)
;   (MSB)[X+OPR2_3][X+OPR2_2][X+OPR2_1][X+OPR2_0](LSB) - second 32-bit unsigned operand of 
;                                                         division (divisor)

    mov   A, 0x00
    mov   [X+TEMP0], A
    mov   [X+TEMP1], A    
    mov   [X+TEMP2], A
    mov   [X+TEMP3], A
    mov   [X+COUNTER], 0x20     ;amount of cycles divider procedure
    
    ;Begin of divider procedure                               
.loop:
    asl   [X+OPR1_0]
    rlc   [X+OPR1_1]
    rlc   [X+OPR1_2]    
    rlc   [X+OPR1_3] 
    rlc   [X+TEMP3]       
    rlc   [X+TEMP2]
    rlc   [X+TEMP1]
    rlc   [X+TEMP0]    
    mov   A, [X+TEMP3]
    sbb   A, [X+OPR2_0]
    mov   A, [X+TEMP2]
    sbb   A, [X+OPR2_1]
    mov   A, [X+TEMP1]
    sbb   A, [X+OPR2_2]
    mov   A, [X+TEMP0]
    sbb   A, [X+OPR2_3]
    jc    .cont
    mov   [X+TEMP0], A
    mov   A, [X+OPR2_0]
    sub   [X+TEMP3], A
    mov   A, [X+OPR2_1]
    sbb   [X+TEMP2], A
    mov   A, [X+OPR2_2]
    sbb   [X+TEMP1], A
    inc   [X+OPR1_0]
.cont:
    dec   [X+COUNTER]
    jnz   .loop
 
    ;End of divider procedure   
; 32-bit unsigned divider result is located here:   
;        (MSB)[X+OPR1_3][X+OPR1_2][X+OPR1_1][X+OPR1_0](LSB)

; copy result to variable pointed by pointer [X+DEST_MSB][X+DEST_LSB]

IF   (SYSTEM_LARGE_MEMORY_MODEL)
    mov   A,[X+DEST_MSB]
    RAM_SETPAGE_MVW A
ENDIF                           ;SYSTEM_LARGE_MEMORY_MODEL
    mov   A,[X+DEST_LSB]
    mov   [ADC10_bfStatus],A
    mov   A,[X+OPR1_3]
    mvi   [ADC10_bfStatus],A
    mov   A,[X+OPR1_2]
    mvi   [ADC10_bfStatus],A
    mov   A,[X+OPR1_1]
    mvi   [ADC10_bfStatus],A
    mov   A,[X+OPR1_0]
    mvi   [ADC10_bfStatus],A

    add   SP, 251                ;restore Stack pointer    
    
    ret
.ENDSECTION
ENDIF; End DieTemp feature

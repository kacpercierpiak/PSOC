;;*****************************************************************************
;;*****************************************************************************
;;  FILENAME: I2CINT.asm
;;   Version: 2.00, Updated on 2015/3/4 at 22:26:25
;;  Generated by PSoC Designer 5.4.3191
;;
;;  DESCRIPTION: I2CHW Master Interrupt Service Routine
;;  This is the interrupt service routine for the Single Master I2C function.
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2015. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

include "m8c.inc"
include "memory.inc"
include "I2CCommon.inc"
include "I2CMstr.inc"

;-----------------------------------------------
;  Global Symbols
;-----------------------------------------------

export     I2C_Read_Count
export    _I2C_Read_Count
export     I2C_Write_Count
export    _I2C_Write_Count

export    pI2C_Read_BufLO
export   _pI2C_Read_BufLO
export    pI2C_Write_BufLO
export   _pI2C_Write_BufLO
export    I2C_RsrcStatus
export   _I2C_RsrcStatus
export    I2C_SlaveAddr
export   _I2C_SlaveAddr

;-----------------------------------------------
; WARNING: The variables below are deprecated
; and have been replaced with Read_BufLO
; and Write_BufLO
;-----------------------------------------------
export    pI2C_Read_Buf
export   _pI2C_Read_Buf
export    pI2C_Write_Buf
export   _pI2C_Write_Buf
;-----------------------------------------------
; END WARNING
;-----------------------------------------------
 
area InterruptRAM(RAM, REL, CON)

;-----------------------------------------------
; Variable Allocation
;-----------------------------------------------

  I2C_SlaveAddr:
 _I2C_SlaveAddr:                             blk      1
  I2C_RsrcStatus:
 _I2C_RsrcStatus:                            blk     1
  I2C_Write_Count:
 _I2C_Write_Count:                           blk    1
IF SYSTEM_LARGE_MEMORY_MODEL
export    pI2C_Write_BufHI
export   _pI2C_Write_BufHI

 pI2C_Write_BufHI:
_pI2C_Write_BufHI:                           blk     1
ENDIF
;-----------------------------------------------
; WARNING: The variable below is deprecated
; and has been replaced Write_BufLO
;-----------------------------------------------
 pI2C_Write_Buf:
_pI2C_Write_Buf:
;-----------------------------------------------
; END WARNING
;-----------------------------------------------
 pI2C_Write_BufLO:
_pI2C_Write_BufLO:                           blk      1

IF I2C_READ_FLASH
export    pI2C_Read_BufHI
export   _pI2C_Read_BufHI

 pI2C_Read_BufHI:
_pI2C_Read_BufHI:                            blk     1
ELSE
IF SYSTEM_LARGE_MEMORY_MODEL
export    pI2C_Read_BufHI
export   _pI2C_Read_BufHI

 pI2C_Read_BufHI:
_pI2C_Read_BufHI:                            blk     1
ENDIF
ENDIF

;-----------------------------------------------
; WARNING: The variable below is deprecated
; and has been replaced Read_BufLO
;-----------------------------------------------
 pI2C_Read_Buf:
_pI2C_Read_Buf:
;-----------------------------------------------
; END WARNING
;-----------------------------------------------
 pI2C_Read_BufLO:
_pI2C_Read_BufLO:                            blk       1

IF I2C_READ_FLASH
export    I2C_Read_CountHI
export   _I2C_Read_CountHI

 I2C_Read_CountHI:
_I2C_Read_CountHI:                           blk    1
ENDIF

 I2C_Read_Count:
_I2C_Read_Count:                             blk      1

;@PSoC_UserCode_INIT@ (Do not change this line.)
;---------------------------------------------------
; Insert your custom declarations below this banner
;---------------------------------------------------

;------------------------
; Includes
;------------------------

	
;------------------------
;  Constant Definitions
;------------------------


;------------------------
; Variable Allocation
;------------------------


;---------------------------------------------------
; Insert your custom declarations above this banner
;---------------------------------------------------
;@PSoC_UserCode_END@ (Do not change this line.)



AREA UserModules (ROM, REL)


export _I2C_ISR
;;****************************************************
;; I2C_MASTER  main entry point from vector 60h
;;
;;****************************************************


_I2C_ISR:
    push A
    push X
IF SYSTEM_LARGE_MEMORY_MODEL
    REG_PRESERVE IDX_PP
ENDIF
    
    ; Stop trap is not recommended because the stop bit cannot be cleared
    ; User may choose to enable it
    ; Add code to handle stop condition here

    tst reg[I2C_SCR], I2C_ADDRIN
    jz DataState
    ;test for a start condition sent out, or bus error, ack from slave, or (lost arb & addr)
AddrState:
    tst reg[I2C_MSCR], I2CM_SNDSTRT
    jnz NoStart
    tst reg[I2C_SCR], ( I2C_LST_BIT )                      ;must be a zero or no slave answered
    jnz SlaveAddrNAK
                                                           ;slave must have acked here
                                                           
    tst [I2C_SlaveAddr], 01                                ;bit 0 = 1 then read (from slave and put it in RAM,
                                                           ;bit 0 = 0 then write to slave and get it from RAM or Flash
    jnz I2C_ReadSlave1stByte                               ;bit 0 was 1
    jmp I2C_WriteSlave1stByte                              ;bit 0 was 0
IF SYSTEM_LARGE_MEMORY_MODEL
    REG_RESTORE IDX_PP
ENDIF
    pop X
    pop A
    reti

DataState:
    or [I2C_RsrcStatus], I2CHW_ISR_ACTIVE
    tst [I2C_SlaveAddr], 01                                ;bit 0 = 1 then read, bit 0 = 0 then write
    jnz I2C_ReadSlave                                      ;bit 0 was 1

StillDataToWrite:
    jmp I2C_WriteSlave                                     ;bit 0 was 0
IF SYSTEM_LARGE_MEMORY_MODEL
    REG_RESTORE IDX_PP
ENDIF
    pop X
    pop A
    reti


SlaveAddrNAK:
    ;;
    ;; all there is to do here is to return, the slave didn't respond so it's not there or needs
    ;; to be tried later.
    ;;
;@PSoC_UserCode_BODY4@ (Do not change this line.)
;---------------------------------------------------
; Insert your custom code below this banner
; to modify the way a NAK from a slave is handled
; possibly set a user defined status
;---------------------------------------------------

;********************************************************
; End user I2C Buffered WRITE (to RAM) Customization
;********************************************************
;@PSoC_UserCode_END@ (Do not change this line.)
;
;;  CONTROL MACRO- writes to the SCR register and accounts for clock speed adjustments if necessary
;
    SetI2C_SCR 0     ;sets the tx/rx bit to receive, generates a stop without sending any data

    and [I2C_RsrcStatus], ~I2CHW_ISR_ACTIVE

IF SYSTEM_LARGE_MEMORY_MODEL
    REG_RESTORE IDX_PP
ENDIF
    pop X
    pop A
    reti

NoStart:
    ;here might test loss of arbitration and the presence of an address bit indicating that the
    ;Master is being addressed as a slave.
    ;;
    ;; there may be a need to indicate that there was a Master transmission
    ;; failure or an unsuccessful attempt.
    ;;
    and [I2C_RsrcStatus], ~I2CHW_ISR_ACTIVE
IF SYSTEM_LARGE_MEMORY_MODEL
    REG_RESTORE IDX_PP
ENDIF
    pop X
    pop A
    reti

I2C_ReadSlave1stByte:
    or [I2C_RsrcStatus], I2CHW_ISR_ACTIVE
    and [I2C_RsrcStatus], ~I2CHW_RD_COMPLETE

;read normal data in from slave immediately after the address is sent, there is no data to read
;but the bus is stalled at byte complete

;
;;  CONTROL MACRO- writes to the SCR register and accounts for clock speed adjustments if necessary
;
    SetI2C_SCR 0     ;sets the tx/rx bit to receive, and clocks a byte in


IF SYSTEM_LARGE_MEMORY_MODEL
    REG_RESTORE IDX_PP
ENDIF
    pop X
    pop A
    reti

I2C_ReadSlave:                                             ;this is just a normal read


;;code snipped from old SW I2C below
;
; MASTER READ from SLAVE
; (and writing to it's own RAM--Write_Buf and Write_Cnt)
;
;@PSoC_UserCode_BODY1_V1.2@ (Do not change this line.)
;---------------------------------------------------
; Insert your custom code below this banner
;---------------------------------------------------

;********************************************************
; By modifying the section from here down to the next comment block
; a user could process data for a custom I2C Master Read (write to RAM) application
; NOTE: I2C handshakes (ACK/NAK may be effected by any introduced bugs)
;********************************************************
   tst   [I2C_bStatus], fI2C_NAKnextWr
   jnz   InStoreData
   ;
   ;process write data here
   ;
   dec   [I2C_Write_Count]
   jc    CompleteRDXfer                                              ; carry set if value became -1
   ;jz    InStoreData                                                                                             ;In theory overflow cant happen but stop the transaction anyway.
   cmp   [I2C_Write_Count], 00                                       ;set nak flag, dec count, and store data
   jz    InNakNextByte
   jmp   InNotBufEnd
InNakNextByte:                                                       ;set the nakflag in I2C_bStatus
   or    [I2C_bStatus], fI2C_NAKnextWr
   jmp   InStoreData
InNotBufEnd:
   and   [I2C_bStatus], ~fI2C_NAKnextWr                              ;clear the nak flag in case it was set from a previous operation
InStoreData:
   ;This is the ONLY place this bit is set  This bit should never be cleared by the isr ONLY by the API ClrWrStatus()
   or    [I2C_RsrcStatus], I2CHW_WR_NOERR                            ;set current status
IF SYSTEM_LARGE_MEMORY_MODEL
   mov   A, [pI2C_Write_BufHI]
ENDIF
   RAM_SETPAGE_IDX A
   mov   X, [pI2C_Write_BufLO]
   mov   A, reg[I2C_DR]
   RAM_CHANGE_PAGE_MODE FLAG_PGMODE_10b
   mov   [X], A
   RAM_CHANGE_PAGE_MODE FLAG_PGMODE_00b
   inc   [pI2C_Write_BufLO]

   tst   [I2C_bStatus], fI2C_NAKnextWr
   jnz   NAK_this_one

;********************************************************
; End user I2C Buffered WRITE (to RAM) Customization
;********************************************************
;@PSoC_UserCode_END@ (Do not change this line.)
;;code snipped form SW I2C to maintain api compatibility above

;
;;  CONTROL MACRO- writes to the SCR register and accounts for clock speed adjustments if necessary
;
    SetI2C_SCR I2C_ACKOUT                                            ;send Ack


IF SYSTEM_LARGE_MEMORY_MODEL
    REG_RESTORE IDX_PP
ENDIF
    pop X
    pop A
    reti

NAK_this_one:

    and  [I2C_bStatus], ~fI2C_NAKnextWr

    ; *****
    ; here we may need to look at the mode that this was called under
    ; what does the user want done on the last byte.  Could be a send restart...
    ; ******
    and   [I2C_RsrcStatus], ~0x07                                    ;clear the read status bits
    or    [I2C_RsrcStatus], I2CHW_RD_NOERR
    or    [I2C_RsrcStatus], I2CHW_RD_COMPLETE

    and [I2C_bStatus], (I2C_RepStart | I2C_NoStop)
    jz      CompleteRDXfer
    and   [I2C_RsrcStatus], ~I2CHW_ISR_ACTIVE
IF SYSTEM_LARGE_MEMORY_MODEL
    REG_RESTORE IDX_PP
ENDIF
    pop X
    pop A
    reti
    ;if neither a repeat start or a NoStop, then this must be a CompleteXfer request.
    ;The NAK (not I2C_SNDACK) bit in I2C_SCR below will automatically generate a stop

CompleteRDXfer:

;
;;  CONTROL MACRO- writes to the SCR register and accounts for clock speed adjustments if necessary
;
    SetI2C_SCR 0                                                     ;send Ack


    and   [I2C_RsrcStatus], ~I2CHW_ISR_ACTIVE
IF SYSTEM_LARGE_MEMORY_MODEL
    REG_RESTORE IDX_PP
ENDIF
    pop X
    pop A
    reti                                                             ;return and wait for the next interrupt (on data)

AckTheRead:

;
;;  CONTROL MACRO- writes to the SCR register and accounts for clock speed adjustments if necessary
;
    SetI2C_SCR I2C_ACKOUT                                            ;send Ack

IF SYSTEM_LARGE_MEMORY_MODEL
    REG_RESTORE IDX_PP
ENDIF
    pop X
    pop A
    reti


I2C_WriteSlave1stByte:
;write normal data to slave
    and [I2C_RsrcStatus], ~I2CHW_WR_COMPLETE
    or [I2C_RsrcStatus], I2CHW_ISR_ACTIVE


I2C_WriteSlave:

    tst reg[I2C_SCR], ( I2C_LST_BIT )                      ;must be a zero or no slave answered
    jnz SlaveDataNAK
    mov A, (I2C_TX)
    push A

;
;MASTER is WRITING TO SLAVE (& reading data from ram or flash buffer)
;
;;code snipped from SW I2C below

I2C_ObtainOutData:


;********************************************************
; here we need to get the next data to output (master-read)
; also set the status byte for use on exit
;********************************************************
IF I2C_READ_FLASH
;@PSoC_UserCode_BODY2_V1.2@ (Do not change this line.)
;---------------------------------------------------
; Insert your custom code below this banner
; to modify the way a master might read non-volitile data
; to send.
;---------------------------------------------------

    tst  [I2C_RsrcStatus],I2CHW_READFLASH
    jz   ReadOutData

    ;
    ;get the data
    ;
    mov  X, [pI2C_Read_BufLO]
    mov  A, [pI2C_Read_BufHI]
    romx
    mov  reg[I2C_DR],A
    dec  [I2C_Read_Count]                                            ;calc addr lsb
    jnc  NoDecHighCount
    dec  [I2C_Read_CountHI]

    jc   MstrWRComplete

NoDecHighCount:

    inc  [pI2C_Read_BufLO]                                           ;set the next flash address to read
    jnc  NoIncHiAddr
    inc  [pI2C_Read_BufHI]
NoIncHiAddr:
   jmp   I2CNormalOutput
;
;****** THERE SHOULD BE NO WAY TO REACH THIS STATE WE'LL JUST TERMINATE THE ACTIVITY SINCE WERE THE MASTER
;********    MAY LEAVE IT IN TO DEAL WITH MULTI MASTER SLAVE CONFIGS THOUGH BUT NOT IN THIS FILE
;
;FlashRdOverflow:
    ;deal with the over flow cond by resending last data byte (dec the low addr)

;   or    [I2C_RsrcStatus], I2CHW_RD_OVERFLOW
;                                                                      ;set count back to 0
;   mov   [I2C_Read_CountHI], 0                                      ;functionally the same as incrementing ffff and less instructions
;   mov   [I2C_Read_Count], 0
;   jmp   I2CNormalRead

;---------------------------------------------------
; Insert your custom code above this banner
;---------------------------------------------------
;@PSoC_UserCode_END@ (Do not change this line.)

ENDIF
;@PSoC_UserCode_BODY3@ (Do not change this line.)
;---------------------------------------------------
; Insert your custom code below this banner
; to modify the way a master might read RAM data to send
; to an I2C device
; By replacing the section from here down to the next block
; a user could process data for a custom I2C READ application
;---------------------------------------------------
ReadOutData:
   ;read the current data byte
IF SYSTEM_LARGE_MEMORY_MODEL
   mov   A, [pI2C_Read_BufHI]
ENDIF
   RAM_SETPAGE_IDX A
   mov   X, [pI2C_Read_BufLO]
   RAM_CHANGE_PAGE_MODE FLAG_PGMODE_10b
   mov   A, [X]
   RAM_CHANGE_PAGE_MODE FLAG_PGMODE_00b
   mov   reg[I2C_DR], A
   dec   [I2C_Read_Count]

   jc    MstrWRComplete
   inc   [pI2C_Read_BufLO]
   jmp   I2CNormalOutput
;
;ram read overflow detected here, just resend the last location in the buffer
;
;********        THERE SHOULD BE NO WAY TO OVERFLOW FOR THIS CASE
;********    MAY LEAVE IT IN TO DEAL WITH MULTI MASTER SLAVE CONFIGS THOUGH BUT NOT IN THIS FILE
;
;RamRDOverflow:
;   or    [I2C_RsrcStatus], I2CHW_RD_OVERFLOW
;   inc   [I2C_Read_Count]                                           ; set back to zero

;---------------------------------------------------
; End user I2C MASTER WRITE TO SLAVE /READ buffer customization section
; Insert your custom code above this banner
;---------------------------------------------------
;@PSoC_UserCode_END@ (Do not change this line.)
;;code snipped form SW I2C to maintain api compatibility above
I2CNormalOutput:

    ;load the bits to set in the I2C_ISR from the stack, The proper bit pattern was previously determined
    ;and place there based on whether or not the previous transmission was our I2C address.
    pop   A

;
;;  CONTROL MACRO- writes to the SCR register and accounts for clock speed adjustments if necessary
;
    SetI2C_SCR A                                                     ;Sets the I2C_TX bit in the I2C_SCR reg.


IF SYSTEM_LARGE_MEMORY_MODEL
    REG_RESTORE IDX_PP
ENDIF
    pop X
    pop A
    reti ;return and wait for the next interrupt (on data)

MstrWRComplete:
    and   [I2C_RsrcStatus], ~0x70                                    ;clear the write status bits
    or    [I2C_RsrcStatus], I2CHW_WR_COMPLETE
    or    [I2C_RsrcStatus], I2CHW_WR_NOERR

    ; *****
    ; here we may need to look at the mode that this was called under
    ; what does the user want done on the last byte.  Could be a send restart...
    ; ******
    and [I2C_bStatus], (I2C_RepStart | I2C_NoStop)
    jz      CompleteWRXfer
    pop  A                                                           ;clear the stack for return
    and  [I2C_RsrcStatus], ~I2CHW_ISR_ACTIVE

IF SYSTEM_LARGE_MEMORY_MODEL
    REG_RESTORE IDX_PP
ENDIF
    pop X
    pop A
    reti
    ;if neither a repeat start or a NoStop, then this must be a CompleteXfer request.
    ; The release of the I2C_TX bit in I2C_SCR below will automatically generate a stop

CompleteWRXfer:

    pop   A

;
;;  CONTROL MACRO- writes to the SCR register and accounts for clock speed adjustments if necessary
;
    SetI2C_SCR 0                                                     ;this will release the bus and generate a stop condition

   and  [I2C_RsrcStatus], ~I2CHW_ISR_ACTIVE
IF SYSTEM_LARGE_MEMORY_MODEL
   REG_RESTORE IDX_PP
ENDIF
   pop X
   pop A
   reti

SlaveDataNAK:
;must also fix up the data buffer.  While it is marginally safe to nak a byte as a slave and 
;store it.  It is NEVER safe as a master to notice that a written byte has been nak'ed by a 
;slave and fail to resend it.
;this piece of code fixes up the count and buffer that the master is using to get data from
;to re-transmit the byte when the next master write is done.
    inc  [I2C_Read_Count]                          ;calc addr lsb
IF I2C_READ_FLASH
    jnc  NoIncHighCount
    inc  [I2C_Read_CountHI]

NoIncHighCount:
ENDIF
    dec  [pI2C_Read_BufLO]                         ;set the next flash address to read
IF SYSTEM_LARGE_MEMORY_MODEL
    jnc  NoDecHiAddr
    dec  [pI2C_Read_BufHI]
NoDecHiAddr:
ELSE
IF I2C_READ_FLASH
    jnc  NoDecHiCAddr
    dec  [pI2C_Read_BufHI]
NoDecHiCAddr:
ENDIF
ENDIF

;;
;; all there is to do here is to return & set status, the slave didn't want any more data
;;
; no pop needed because the nak is detected before the push happens above

;
;;  CONTROL MACRO- writes to the SCR register and accounts for clock speed adjustments if necessary
;
    SetI2C_SCR 0                                                     ;this will release the bus and generate a stop condition

    and [I2C_RsrcStatus], ~I2CHW_ISR_ACTIVE
    and   [I2C_RsrcStatus], ~0x70                                    ;clear the write status bits
    or    [I2C_RsrcStatus], I2CHW_WR_COMPLETE
    or    [I2C_RsrcStatus], I2CHW_WR_OVERFLOW
IF SYSTEM_LARGE_MEMORY_MODEL
    REG_RESTORE IDX_PP
ENDIF
    pop X
    pop A
   reti

STOPTRAP:
    ;
    ;   If interrupt on STOP condition is enabled:
    ;   Add user code to process stop (not recommended becuase I2C bus is NOT stalled and ISR
    ;   may block reception of ongoing transactions/addresses
    ;   STOP condition is never detected when a repeat start is used by the master.
    ;
    and [I2C_RsrcStatus], ~I2CHW_ISR_ACTIVE
IF SYSTEM_LARGE_MEMORY_MODEL
    REG_RESTORE IDX_PP
ENDIF
    pop X
    pop A
    reti

; end of file I2CINT.asm

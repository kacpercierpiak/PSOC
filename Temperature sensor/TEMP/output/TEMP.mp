Project:      output/TEMP
Build Number: 0
Date:         Mon May 18 12:35:55 2020
Compiler:     ICCM8C
Version:      8.05.01E


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0150   00C8 =    200. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       0150  _arTherm
       01AC  LoadConfigTBL_MF_TEMP_Bank0
       01DF  LoadConfigTBL_MF_TEMP_Bank1
       0218  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   0218   0002 =      2. bytes (rel,con,rom,proclab)

       Addr  Global Symbol
      -----  --------------------------------
       0218  __func_lit_start
       021A  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     psoc_config   021A   00EA =    234. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       021A  LoadConfigTBL_MF_TEMP_Ordered
       029F  _LoadConfigInit
       029F  LoadConfigInit
       02A9  _LoadConfig_MF_TEMP
       02A9  LoadConfig_MF_TEMP
       0304  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   0304   0305 =    773. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0304  _LED_RED_On
       0304  LED_RED_On
       0308  _LED_RED_Start
       0308  _LED_RED_Off
       0308  _LED_RED_Stop
       0308  LED_RED_Start
       0308  LED_RED_Off
       0308  LED_RED_Stop
       030A  _LED_RED_Switch
       030A  LED_RED_Switch
       0322  LED_RED_Invert
       0322  _LED_RED_Invert
       0331  _LED_RED_GetState
       0331  LED_RED_GetState
       0341  LED_GREEN_On
       0341  _LED_GREEN_On
       0345  LED_GREEN_Off
       0345  _LED_GREEN_Off
       0345  LED_GREEN_Stop
       0345  LED_GREEN_Start
       0345  _LED_GREEN_Start
       0345  _LED_GREEN_Stop
       0347  LED_GREEN_Switch
       0347  _LED_GREEN_Switch
       035F  _LED_GREEN_Invert
       035F  LED_GREEN_Invert
       036E  LED_GREEN_GetState
       036E  _LED_GREEN_GetState
       037E  _LED_BLUE_On
       037E  LED_BLUE_On
       0382  LED_BLUE_Off
       0382  _LED_BLUE_Start
       0382  LED_BLUE_Start
       0382  _LED_BLUE_Stop
       0382  LED_BLUE_Stop
       0382  _LED_BLUE_Off
       0384  LED_BLUE_Switch
       0384  _LED_BLUE_Switch
       039C  _LED_BLUE_Invert
       039C  LED_BLUE_Invert
       03AB  LED_BLUE_GetState
       03AB  _LED_BLUE_GetState
       03BB  _EzI2Cs_ISR
       049E  _ADC10_ADC_ISR
       04D1  _ADC10_CNT_ISR
       04D4  _ADC10_Start
       04D4  ADC10_Start
       04EF  ADC10_Stop
       04EF  _ADC10_Stop
       0502  _ADC10_StartADC
       0502  ADC10_StartADC
       0523  _ADC10_StopADC
       0523  ADC10_StopADC
       0530  ADC10_fIsDataAvailable
       0530  _ADC10_fIsDataAvailable
       0536  ADC10_iGetDataClearFlag
       0536  _ADC10_iGetDataClearFlag
       053C  _ADC10_iGetData
       053C  ADC10_iGetData
       054A  _ADC10_ClearFlag
       054A  ADC10_ClearFlag
       0551  _ADC10_iCal
       0551  ADC10_iCal
       0609  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0609   0AE1 =   2785. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0609  _LEDControl_INIT
       0609  __text_start
       0618  _LEDControl_ChangeState
       064F  _LEDControl_ChangeStateSwitch
       0718  _LEDControl_ChangeFrequency
       07FD  _LEDControl_Blink
       08AD  _main
       092D  _CalculateTemperature
       0E2F  _GetValueFromThermistor
       0F16  _GetTemperature
       0F56  _TempControl_GetValue
       10E0  __lpmw
       10EA  __xidata_start
       10EA  __text_end
       10F5  __xidata_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             TOP   0000   014F =    335. bytes (abs,ovr,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0068  __Start
       014C  _bGetPowerSetting
       014C  bGetPowerSetting

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                    InterruptRAM   0000   000D =     13. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  _Port_1_Data_SHADE
       0000  _NO_SHADOW
       0000  NO_SHADOW
       0000  Port_1_Data_SHADE
       0001  _EzI2Cs_varPage
       0001  _EzI2Cs_bState
       0001  EzI2Cs_varPage
       0001  EzI2Cs_bState
       0002  _EzI2Cs_bRAM_RWoffset
       0002  EzI2Cs_bRAM_RWoffset
       0003  EzI2Cs_bRAM_RWcntr
       0003  _EzI2Cs_bRAM_RWcntr
       0004  _EzI2Cs_pRAM_Buf_Addr_MSB
       0004  EzI2Cs_pRAM_Buf_Addr_MSB
       0005  EzI2Cs_pRAM_Buf_Addr_LSB
       0005  _EzI2Cs_pRAM_Buf_Addr_LSB
       0006  _EzI2Cs_bRAM_Buf_Size
       0006  EzI2Cs_bRAM_Buf_Size
       0007  EzI2Cs_bRAM_Buf_WSize
       0007  _EzI2Cs_bRAM_Buf_WSize
       0008  _EzI2Cs_bBusy_Flag
       0008  EzI2Cs_bBusy_Flag
       0009  ADC10_bTempMSB
       000A  ADC10_iResult
       000A  _ADC10_iResult
       000C  ADC10_bfStatus
       000C  _ADC10_bfStatus

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
               virtual_registers   000D   000F =     15. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       000D  __rZ
       000E  __rY
       000F  __rX
       0010  __r11
       0011  __r10
       0012  __r9
       0013  __r8
       0014  __r7
       0015  __r6
       0016  __r5
       0017  __r4
       0018  __r3
       0019  __r2
       001A  __r1
       001B  __r0

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0000   0006 =      6. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __data_start
       001C  _LEDControl_BT
       001E  _LEDControl_GT
       0020  _LEDControl_RT

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/ledcontrol.o	[ ledcontrol.c ]
obj/main.o	[ main.c ]
obj/tempcontrol.o	[ tempcontrol.c ]
<library>	[ psocconfigtbl.asm, psocconfig.asm, led_red.asm, led_green.asm, led_blue.asm, ezi2csint.asm ]
[ adc10int.asm, adc10.asm, rZ.asm, rY.asm, rX.asm, r11.asm, r10.asm, r9.asm, r8.asm, r7.asm, r6.asm, r5.asm ]
[ r4.asm, r3.asm, r2.asm, r1.asm, r0.asm, divmod_32x32_32_util.asm, i_div32_block_util.asm, i_div32_not_util.asm ]
[ mul32_util.asm, lpmw.s ]

Area Definitions

-blit:0x150.0x1fff
-bdata:0.0x100
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0xd
-BMF_TEMP_RAM
-rwh:SSCParmBlk:0xf7.0xff


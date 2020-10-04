Project:      output/MF_LIGHT
Build Number: 0
Date:         Mon May 18 02:41:05 2020
Compiler:     ICCM8C
Version:      8.05.01E


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0150   0060 =     96. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       0150  LoadConfigTBL_MF_LIGHT_Bank0
       017D  LoadConfigTBL_MF_LIGHT_Bank1
       01B0  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   01B0   0002 =      2. bytes (rel,con,rom,proclab)

       Addr  Global Symbol
      -----  --------------------------------
       01B0  __func_lit_start
       01B2  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     psoc_config   01B2   00EA =    234. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       01B2  LoadConfigTBL_MF_LIGHT_Ordered
       0237  _LoadConfigInit
       0237  LoadConfigInit
       0241  _LoadConfig_MF_LIGHT
       0241  LoadConfig_MF_LIGHT
       029C  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   029C   0305 =    773. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       029C  _LED_RED_On
       029C  LED_RED_On
       02A0  _LED_RED_Start
       02A0  _LED_RED_Off
       02A0  _LED_RED_Stop
       02A0  LED_RED_Start
       02A0  LED_RED_Off
       02A0  LED_RED_Stop
       02A2  _LED_RED_Switch
       02A2  LED_RED_Switch
       02BA  LED_RED_Invert
       02BA  _LED_RED_Invert
       02C9  _LED_RED_GetState
       02C9  LED_RED_GetState
       02D9  LED_GREEN_On
       02D9  _LED_GREEN_On
       02DD  LED_GREEN_Off
       02DD  _LED_GREEN_Off
       02DD  LED_GREEN_Stop
       02DD  LED_GREEN_Start
       02DD  _LED_GREEN_Start
       02DD  _LED_GREEN_Stop
       02DF  LED_GREEN_Switch
       02DF  _LED_GREEN_Switch
       02F7  _LED_GREEN_Invert
       02F7  LED_GREEN_Invert
       0306  LED_GREEN_GetState
       0306  _LED_GREEN_GetState
       0316  _LED_BLUE_On
       0316  LED_BLUE_On
       031A  LED_BLUE_Off
       031A  _LED_BLUE_Start
       031A  LED_BLUE_Start
       031A  _LED_BLUE_Stop
       031A  LED_BLUE_Stop
       031A  _LED_BLUE_Off
       031C  LED_BLUE_Switch
       031C  _LED_BLUE_Switch
       0334  _LED_BLUE_Invert
       0334  LED_BLUE_Invert
       0343  LED_BLUE_GetState
       0343  _LED_BLUE_GetState
       0353  _EzI2Cs_ISR
       0436  _ADC10_ADC_ISR
       0469  _ADC10_CNT_ISR
       046C  _ADC10_Start
       046C  ADC10_Start
       0487  ADC10_Stop
       0487  _ADC10_Stop
       049A  _ADC10_StartADC
       049A  ADC10_StartADC
       04BB  _ADC10_StopADC
       04BB  ADC10_StopADC
       04C8  ADC10_fIsDataAvailable
       04C8  _ADC10_fIsDataAvailable
       04CE  ADC10_iGetDataClearFlag
       04CE  _ADC10_iGetDataClearFlag
       04D4  _ADC10_iGetData
       04D4  ADC10_iGetData
       04E2  _ADC10_ClearFlag
       04E2  ADC10_ClearFlag
       04E9  _ADC10_iCal
       04E9  ADC10_iCal
       05A1  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   05A1   0540 =   1344. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       05A1  _LEDControl_INIT
       05A1  __text_start
       05B0  _LEDControl_ChangeState
       05E7  _LEDControl_ChangeStateSwitch
       06B0  _LEDControl_ChangeFrequency
       0795  _LEDControl_Blink
       0845  _LightControl_INIT
       0861  _LightControl_Scan
       0953  _main
       0AE1  __text_end
       0AE1  __xidata_start
       0AEF  __xidata_end

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
               virtual_registers   000D   0005 =      5. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       000D  __rZ
       000E  __rY
       000F  __rX
       0010  __r1
       0011  __r0

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0000   000E =     14. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __data_start
       0012  _v1
       0016  _value
       001A  _LEDControl_GT
       001C  _LEDControl_BT
       001E  _LEDControl_RT

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/ledcontrol.o	[ ledcontrol.c ]
obj/lightcontrol.o	[ lightcontrol.c ]
obj/main.o	[ main.c ]
<library>	[ psocconfigtbl.asm, psocconfig.asm, led_red.asm, led_green.asm, led_blue.asm, ezi2csint.asm ]
[ adc10int.asm, adc10.asm, rZ.asm, rY.asm, rX.asm, r1.asm, r0.asm, divmod_32x32_32_util.asm, i_div32_block_util.asm ]
[ i_div32_not_util.asm, mul32_util.asm ]

Area Definitions

-blit:0x150.0x1fff
-bdata:0.0x100
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0xd
-BMF_LIGHT_RAM
-rwh:SSCParmBlk:0xf7.0xff


Project:      output/Proxy
Build Number: 0
Date:         Tue Jun 02 13:24:23 2020
Compiler:     ICCM8C
Version:      7.05.00


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0170   007C =    124. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       0170  LoadConfigTBL_capsense_Bank0
       01AD  LoadConfigTBL_capsense_Bank1
       01EC  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   01EC   0002 =      2. bytes (rel,con,rom,proclab)

       Addr  Global Symbol
      -----  --------------------------------
       01EC  __func_lit_start
       01EE  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     psoc_config   01EE   00ED =    237. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       01EE  LoadConfigTBL_capsense_Ordered
       0273  LoadConfigInit
       0273  _LoadConfigInit
       0280  LoadConfig_capsense
       0280  _LoadConfig_capsense
       02DB  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   02DB   0567 =   1383. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       02DB  _LED_RED_On
       02DB  LED_RED_On
       02DF  LED_RED_Start
       02DF  LED_RED_Off
       02DF  _LED_RED_Stop
       02DF  _LED_RED_Off
       02DF  LED_RED_Stop
       02DF  _LED_RED_Start
       02E1  LED_RED_Switch
       02E1  _LED_RED_Switch
       02F9  _LED_RED_Invert
       02F9  LED_RED_Invert
       0308  _LED_RED_GetState
       0308  LED_RED_GetState
       0318  LED_GREEN_On
       0318  _LED_GREEN_On
       031C  _LED_GREEN_Off
       031C  _LED_GREEN_Stop
       031C  LED_GREEN_Stop
       031C  LED_GREEN_Off
       031C  _LED_GREEN_Start
       031C  LED_GREEN_Start
       031E  _LED_GREEN_Switch
       031E  LED_GREEN_Switch
       0336  _LED_GREEN_Invert
       0336  LED_GREEN_Invert
       0345  _LED_GREEN_GetState
       0345  LED_GREEN_GetState
       0355  _LED_BLUE_On
       0355  LED_BLUE_On
       0359  LED_BLUE_Stop
       0359  _LED_BLUE_Off
       0359  LED_BLUE_Start
       0359  LED_BLUE_Off
       0359  _LED_BLUE_Stop
       0359  _LED_BLUE_Start
       035B  LED_BLUE_Switch
       035B  _LED_BLUE_Switch
       0373  _LED_BLUE_Invert
       0373  LED_BLUE_Invert
       0382  _LED_BLUE_GetState
       0382  LED_BLUE_GetState
       0392  _CSD_CNT_ISR
       0395  _CSD_CMP_ISR
       0397  _CSD_CMP0_ISR
       03CE  _CSD_UpdateSensorBaseline
       03CE  CSD_UpdateSensorBaseline
       0495  _CSD_bIsSensorActive
       0495  CSD_bIsSensorActive
       053B  CSD_SetDefaultFingerThresholds
       053B  _CSD_SetDefaultFingerThresholds
       0550  CSD_InitializeBaselines
       0550  _CSD_InitializeBaselines
       057A  _CSD_InitializeSensorBaseline
       057A  CSD_InitializeSensorBaseline
       059D  _CSD_bIsAnySensorActive
       059D  CSD_bIsAnySensorActive
       05B6  _CSD_UpdateAllBaselines
       05B6  CSD_UpdateAllBaselines
       05C0  CSD_VC1_Table
       0600  CSD_Start
       0600  _CSD_Start
       0642  CSD_SetScanMode
       0642  _CSD_SetScanMode
       06BA  CSD_SetRefValue
       06BA  _CSD_SetRefValue
       06F2  CSD_ClearSensors
       06F2  _CSD_ClearSensors
       06FE  CSD_Stop
       06FE  _CSD_Stop
       071D  _CSD_Resume
       071D  CSD_Resume
       0745  CSD_wGetPortPin
       0745  _CSD_wGetPortPin
       074E  _CSD_EnableSensor
       074E  CSD_EnableSensor
       077C  _CSD_DisableSensor
       077C  CSD_DisableSensor
       07AA  _CSD_ScanSensor
       07AA  CSD_ScanSensor
       07FF  CSD_ScanAllSensors
       07FF  _CSD_ScanAllSensors
       0809  CSD_wReadSensor
       0809  _CSD_wReadSensor
       0842  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0842   03EE =   1006. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0842  _LEDControl_INIT
       0842  __text_start
       0851  _LEDControl_ChangeState
       0888  _LEDControl_ChangeStateSwitch
       09A6  _LEDControl_ValueValidation
       0A08  _LEDControl_ChangeFrequency
       0AD5  _LEDControl_Blink
       0B9F  _main
       0BE2  _ProxyControl_INIT
       0BF1  _ProxyControl_Proxy
       0C30  __text_end
       0C30  __xidata_start
       0C3B  __xidata_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             TOP   0000   012B =    299. bytes (abs,ovr,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0068  __Start
       0128  _bGetPowerSetting
       0128  bGetPowerSetting

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                    InterruptRAM   0000   0017 =     23. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  Port_1_Data_SHADE
       0000  _Port_1_Data_SHADE
       0000  NO_SHADOW
       0000  _NO_SHADOW
       0001  Port_2_Data_SHADE
       0001  _Port_2_Data_SHADE
       0002  CSD_bNoiseThreshold
       0002  _CSD_bNoiseThreshold
       0003  CSD_bNegativeNoiseThreshold
       0003  _CSD_bNegativeNoiseThreshold
       0004  _CSD_bBaselineUpdateThreshold
       0004  CSD_bBaselineUpdateThreshold
       0005  _CSD_bHysteresis
       0005  CSD_bHysteresis
       0006  _CSD_bDebounce
       0006  CSD_bDebounce
       0007  _CSD_bLowBaselineReset
       0007  CSD_bLowBaselineReset
       0008  _CSD_bEndOfArray
       0008  CSD_bEndOfArray
       0009  _CSD_fIsPressed
       0009  CSD_fIsPressed
       000A  CSD_bCurPos
       000A  _CSD_bCurPos
       000B  CSD_bSnsMaskPtr
       000B  _CSD_bSnsMaskPtr
       000F  CSD_MaxADCValueMSB
       0010  CSD_wADC_Result
       0010  _CSD_wADC_Result
       0012  _CSD_bADCStatus
       0012  CSD_bADCStatus
       0016  CSD_bSensorNum
       0016  _CSD_bSensorNum

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            ram2   0000   0005 =      5. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       001D  CSD_baBtnFThreshold
       001D  _CSD_baBtnFThreshold
       001E  CSD_baSnsOnMask
       001E  _CSD_baSnsOnMask
       001F  CSD_baSnsDebounce
       0020  CSD_baLowBaselineReset

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            ram1   0000   0004 =      4. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0021  _CSD_waSnsBaseline
       0021  CSD_waSnsBaseline
       0023  _CSD_waSnsDiff
       0023  CSD_waSnsDiff

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0000   0002 =      2. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __bss_start
       002B  CSD_waSnsResult
       002B  _CSD_waSnsResult

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
               virtual_registers   0017   0005 =      5. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0017  __rZ
       0018  __rY
       0019  __rX
       001A  __r1
       001B  __r0

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0000   0006 =      6. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __data_start
       0025  _LEDControl_RT
       0027  _LEDControl_BT
       0029  _LEDControl_GT

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/ledcontrol.o	[ ledcontrol.c ]
obj/main.o	[ main.c ]
obj/proxycontrol.o	[ proxycontrol.c ]
<library>	[ psocconfigtbl.asm, psocconfig.asm, led_red.asm, led_green.asm, led_blue.asm, csdint.asm, csdhl.asm ]
[ csd.asm, rZ.asm, rY.asm, rX.asm, r1.asm, r0.asm, mul16_util.asm ]

Area Definitions

-blit:0x170.0x1fff
-bdata:0.0x100
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0x17
-Bcapsense_RAM
-rwh:SSCParmBlk:0xf7.0xff


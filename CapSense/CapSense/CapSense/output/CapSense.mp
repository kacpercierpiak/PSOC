Project:      output/CapSense
Build Number: 0
Date:         Tue Jun 02 15:33:53 2020
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
                     UserModules   02DB   0AB3 =   2739. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       02DB  _LED_RED_On
       02DB  LED_RED_On
       02DF  _LED_RED_Stop
       02DF  LED_RED_Start
       02DF  _LED_RED_Start
       02DF  LED_RED_Stop
       02DF  LED_RED_Off
       02DF  _LED_RED_Off
       02E1  LED_RED_Switch
       02E1  _LED_RED_Switch
       02F9  LED_RED_Invert
       02F9  _LED_RED_Invert
       0308  LED_RED_GetState
       0308  _LED_RED_GetState
       0318  _LED_GREEN_On
       0318  LED_GREEN_On
       031C  LED_GREEN_Start
       031C  LED_GREEN_Stop
       031C  _LED_GREEN_Stop
       031C  _LED_GREEN_Start
       031C  LED_GREEN_Off
       031C  _LED_GREEN_Off
       031E  LED_GREEN_Switch
       031E  _LED_GREEN_Switch
       0336  _LED_GREEN_Invert
       0336  LED_GREEN_Invert
       0345  _LED_GREEN_GetState
       0345  LED_GREEN_GetState
       0355  LED_BLUE_On
       0355  _LED_BLUE_On
       0359  LED_BLUE_Stop
       0359  _LED_BLUE_Off
       0359  LED_BLUE_Off
       0359  _LED_BLUE_Start
       0359  LED_BLUE_Start
       0359  _LED_BLUE_Stop
       035B  _LED_BLUE_Switch
       035B  LED_BLUE_Switch
       0373  LED_BLUE_Invert
       0373  _LED_BLUE_Invert
       0382  _LED_BLUE_GetState
       0382  LED_BLUE_GetState
       0392  CSD_Sensor_Table
       0392  _CSD_Sensor_Table
       03A2  _CSD_Group_Table
       03A2  CSD_Group_Table
       03AE  _CSD_Diplex_Table
       03AE  CSD_Diplex_Table
       03B2  _CSD_CNT_ISR
       03B5  _CSD_CMP_ISR
       03B7  _CSD_CMP0_ISR
       03EE  _CSD_UpdateSensorBaseline
       03EE  CSD_UpdateSensorBaseline
       04B5  CSD_bIsSensorActive
       04B5  _CSD_bIsSensorActive
       055B  _CSD_SetDefaultFingerThresholds
       055B  CSD_SetDefaultFingerThresholds
       0570  _CSD_InitializeBaselines
       0570  CSD_InitializeBaselines
       059A  CSD_InitializeSensorBaseline
       059A  _CSD_InitializeSensorBaseline
       05BD  CSD_bIsAnySensorActive
       05BD  _CSD_bIsAnySensorActive
       05D6  _CSD_UpdateAllBaselines
       05D6  CSD_UpdateAllBaselines
       05E0  _CSD_wGetCentroidPos
       05E0  CSD_wGetCentroidPos
       0817  CSD_wGetRadialInc
       0817  _CSD_wGetRadialInc
       08E8  _CSD_wGetRadialPos
       08E8  CSD_wGetRadialPos
       0AFE  CSD_VC1_Table
       0B3E  CSD_Start
       0B3E  _CSD_Start
       0B80  _CSD_SetScanMode
       0B80  CSD_SetScanMode
       0BF8  CSD_SetRefValue
       0BF8  _CSD_SetRefValue
       0C30  _CSD_ClearSensors
       0C30  CSD_ClearSensors
       0C3C  CSD_Stop
       0C3C  _CSD_Stop
       0C5B  CSD_Resume
       0C5B  _CSD_Resume
       0C91  CSD_wGetPortPin
       0C91  _CSD_wGetPortPin
       0C9A  _CSD_EnableSensor
       0C9A  CSD_EnableSensor
       0CC8  CSD_DisableSensor
       0CC8  _CSD_DisableSensor
       0CF6  CSD_ScanSensor
       0CF6  _CSD_ScanSensor
       0D4B  CSD_ScanAllSensors
       0D4B  _CSD_ScanAllSensors
       0D55  _CSD_wReadSensor
       0D55  CSD_wReadSensor
       0D8E  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0D8E   0721 =   1825. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0D8E  __text_start
       0D8E  _CapSenseControl_INIT
       0DC4  _CapSenseControl_GetNewBlinkFreq
       0ED5  _CapSenseControl_ChangeActiveLED
       0F47  _CapSenseControl_DoScan
       0F8D  _LEDControl_INIT
       0F9C  _LEDControl_ChangeState
       0FD3  _LEDControl_ChangeStateSwitch
       10F1  _LEDControl_ValueValidation
       1153  _LEDControl_ChangeFrequency
       1220  _LEDControl_Blink
       12EA  _main
       1478  _abs
       14AF  __xidata_start
       14AF  __text_end
       14C4  __xidata_end

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
                    InterruptRAM   0000   0038 =     56. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  _NO_SHADOW
       0000  Port_1_Data_SHADE
       0000  _Port_1_Data_SHADE
       0000  NO_SHADOW
       0001  Port_2_Data_SHADE
       0001  _Port_2_Data_SHADE
       0002  _CSD_bNoiseThreshold
       0002  CSD_bNoiseThreshold
       0003  CSD_bNegativeNoiseThreshold
       0003  _CSD_bNegativeNoiseThreshold
       0004  _CSD_bBaselineUpdateThreshold
       0004  CSD_bBaselineUpdateThreshold
       0005  _CSD_bHysteresis
       0005  CSD_bHysteresis
       0006  CSD_bDebounce
       0006  _CSD_bDebounce
       0007  _CSD_bLowBaselineReset
       0007  CSD_bLowBaselineReset
       0008  CSD_bEndOfArray
       0008  _CSD_bEndOfArray
       0009  _CSD_fIsPressed
       0009  CSD_fIsPressed
       000A  CSD_bCurPos
       000A  _CSD_bCurPos
       000B  _CSD_bSnsMaskPtr
       000B  CSD_bSnsMaskPtr
       000F  _CSD_wDenom
       000F  CSD_wDenom
       0011  _CSD_dNumer
       0011  CSD_dNumer
       0013  CSD_wCtrdPos
       0013  _CSD_wCtrdPos
       0015  _CSD_dMultTempX
       0015  CSD_dMultTempX
       0019  CSD_dMultTempY
       0019  _CSD_dMultTempY
       001E  _CSD_bCurCtrdStartPos
       001E  CSD_bCurCtrdStartPos
       001F  CSD_bCurCtrdSize
       001F  _CSD_bCurCtrdSize
       0020  CSD_bBiggestCtrdStartPos
       0020  _CSD_bBiggestCtrdStartPos
       0021  _CSD_bBiggestCtrdSize
       0021  CSD_bBiggestCtrdSize
       0022  CSD_wCurPkValue
       0022  _CSD_wCurPkValue
       0024  _CSD_bCurPkPos
       0024  CSD_bCurPkPos
       0026  CSD_bDiplexMSB
       0026  _CSD_bDiplexMSB
       0027  _CSD_bDiplexLSB
       0027  CSD_bDiplexLSB
       0028  _CSD_wDivBtwSns
       0028  CSD_wDivBtwSns
       0030  CSD_MaxADCValueMSB
       0031  CSD_wADC_Result
       0031  _CSD_wADC_Result
       0033  _CSD_bADCStatus
       0033  CSD_bADCStatus
       0037  CSD_bSensorNum
       0037  _CSD_bSensorNum

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            ram2   0000   0021 =     33. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0040  CSD_baBtnFThreshold
       0040  _CSD_baBtnFThreshold
       0048  CSD_baSnsOnMask
       0048  _CSD_baSnsOnMask
       0049  CSD_baSnsDebounce
       0051  CSD_baLowBaselineReset

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            ram1   0000   0020 =     32. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0059  _CSD_waSnsBaseline
       0059  CSD_waSnsBaseline
       0069  _CSD_waSnsDiff
       0069  CSD_waSnsDiff

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0000   0016 =     22. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __bss_start
       0079  CSD_waSnsResult
       0079  _CSD_waSnsResult
       0092  _CSD_waSliderPrevPos
       0092  CSD_waSliderPrevPos
       0094  _CSD_waSliderCurrPos
       0094  CSD_waSliderCurrPos

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
               virtual_registers   0089   0007 =      7. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0089  __rZ
       008A  __rY
       008B  __rX
       008C  __r3
       008D  __r2
       008E  __r1
       008F  __r0

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0000   000F =     15. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __data_start
       0096  _loopQty
       0098  _fingerposition
       009A  _LEDControl_BT
       009C  _CapSenseControl_Scan
       009E  _CapSenseControl_Data
       00A0  _LEDControl_RT
       00A2  _LEDControl_GT
       00A4  _CapSensPush

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/capsensecontrol.o	[ capsensecontrol.c ]
obj/ledcontrol.o	[ ledcontrol.c ]
obj/main.o	[ main.c ]
<library>	[ psocconfigtbl.asm, psocconfig.asm, led_red.asm, led_green.asm, led_blue.asm, csdtable.asm, csdint.asm ]
[ csdhl.asm, csd.asm, rZ.asm, rY.asm, rX.asm, r3.asm, r2.asm, r1.asm, r0.asm, divmod_16x16_16_util.asm ]
[ i_div16_block_util.asm, mul16_util.asm, abs.s ]

Area Definitions

-blit:0x170.0x1fff
-bdata:0.0x100
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0x89
-Bcapsense_RAM
-rwh:SSCParmBlk:0xf7.0xff


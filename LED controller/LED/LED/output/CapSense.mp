Project:      output/CapSense
Build Number: 0
Date:         Tue May 19 21:58:13 2020
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
                     UserModules   02DB   0B96 =   2966. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       02DB  LED_RED_On
       02DB  _LED_RED_On
       02DF  LED_RED_Off
       02DF  _LED_RED_Off
       02DF  LED_RED_Stop
       02DF  _LED_RED_Stop
       02DF  _LED_RED_Start
       02DF  LED_RED_Start
       02E1  LED_RED_Switch
       02E1  _LED_RED_Switch
       02F9  _LED_RED_Invert
       02F9  LED_RED_Invert
       0308  LED_RED_GetState
       0308  _LED_RED_GetState
       0318  LED_GREEN_On
       0318  _LED_GREEN_On
       031C  _LED_GREEN_Stop
       031C  _LED_GREEN_Off
       031C  LED_GREEN_Start
       031C  LED_GREEN_Off
       031C  LED_GREEN_Stop
       031C  _LED_GREEN_Start
       031E  _LED_GREEN_Switch
       031E  LED_GREEN_Switch
       0336  _LED_GREEN_Invert
       0336  LED_GREEN_Invert
       0345  _LED_GREEN_GetState
       0345  LED_GREEN_GetState
       0355  LED_BLUE_On
       0355  _LED_BLUE_On
       0359  _LED_BLUE_Off
       0359  _LED_BLUE_Start
       0359  LED_BLUE_Start
       0359  _LED_BLUE_Stop
       0359  LED_BLUE_Stop
       0359  LED_BLUE_Off
       035B  LED_BLUE_Switch
       035B  _LED_BLUE_Switch
       0373  LED_BLUE_Invert
       0373  _LED_BLUE_Invert
       0382  LED_BLUE_GetState
       0382  _LED_BLUE_GetState
       0392  _EzI2Cs_ISR
       0475  _CSD_Sensor_Table
       0475  CSD_Sensor_Table
       0485  _CSD_Group_Table
       0485  CSD_Group_Table
       0491  _CSD_Diplex_Table
       0491  CSD_Diplex_Table
       0495  _CSD_CNT_ISR
       0498  _CSD_CMP_ISR
       049A  _CSD_CMP0_ISR
       04D1  CSD_UpdateSensorBaseline
       04D1  _CSD_UpdateSensorBaseline
       0598  CSD_bIsSensorActive
       0598  _CSD_bIsSensorActive
       063E  CSD_SetDefaultFingerThresholds
       063E  _CSD_SetDefaultFingerThresholds
       0653  CSD_InitializeBaselines
       0653  _CSD_InitializeBaselines
       067D  CSD_InitializeSensorBaseline
       067D  _CSD_InitializeSensorBaseline
       06A0  _CSD_bIsAnySensorActive
       06A0  CSD_bIsAnySensorActive
       06B9  CSD_UpdateAllBaselines
       06B9  _CSD_UpdateAllBaselines
       06C3  CSD_wGetCentroidPos
       06C3  _CSD_wGetCentroidPos
       08FA  _CSD_wGetRadialInc
       08FA  CSD_wGetRadialInc
       09CB  _CSD_wGetRadialPos
       09CB  CSD_wGetRadialPos
       0BE1  CSD_VC1_Table
       0C21  CSD_Start
       0C21  _CSD_Start
       0C63  CSD_SetScanMode
       0C63  _CSD_SetScanMode
       0CDB  CSD_SetRefValue
       0CDB  _CSD_SetRefValue
       0D13  _CSD_ClearSensors
       0D13  CSD_ClearSensors
       0D1F  CSD_Stop
       0D1F  _CSD_Stop
       0D3E  _CSD_Resume
       0D3E  CSD_Resume
       0D74  CSD_wGetPortPin
       0D74  _CSD_wGetPortPin
       0D7D  _CSD_EnableSensor
       0D7D  CSD_EnableSensor
       0DAB  _CSD_DisableSensor
       0DAB  CSD_DisableSensor
       0DD9  CSD_ScanSensor
       0DD9  _CSD_ScanSensor
       0E2E  CSD_ScanAllSensors
       0E2E  _CSD_ScanAllSensors
       0E38  _CSD_wReadSensor
       0E38  CSD_wReadSensor
       0E71  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0E71   070F =   1807. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0E71  __text_start
       0E71  _CapSenseControl_INIT
       0EA7  _CapSenseControl_GetNewBlinkFreq
       1020  _CapSenseControl_ChangeActiveLED
       1092  _CapSenseControl_DoScan
       10D8  _LEDControl_INIT
       10E7  _LEDControl_ChangeState
       111E  _LEDControl_ChangeStateSwitch
       1204  _LEDControl_ChangeFrequency
       1321  _LEDControl_Blink
       13EB  _main
       1549  _abs
       1580  __xidata_start
       1580  __text_end
       1595  __xidata_end

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
                    InterruptRAM   0000   0040 =     64. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  NO_SHADOW
       0000  Port_1_Data_SHADE
       0000  _NO_SHADOW
       0000  _Port_1_Data_SHADE
       0001  _Port_2_Data_SHADE
       0001  Port_2_Data_SHADE
       0002  EzI2Cs_bState
       0002  EzI2Cs_varPage
       0002  _EzI2Cs_bState
       0002  _EzI2Cs_varPage
       0003  _EzI2Cs_bRAM_RWoffset
       0003  EzI2Cs_bRAM_RWoffset
       0004  _EzI2Cs_bRAM_RWcntr
       0004  EzI2Cs_bRAM_RWcntr
       0005  EzI2Cs_pRAM_Buf_Addr_MSB
       0005  _EzI2Cs_pRAM_Buf_Addr_MSB
       0006  EzI2Cs_pRAM_Buf_Addr_LSB
       0006  _EzI2Cs_pRAM_Buf_Addr_LSB
       0007  _EzI2Cs_bRAM_Buf_Size
       0007  EzI2Cs_bRAM_Buf_Size
       0008  EzI2Cs_bRAM_Buf_WSize
       0008  _EzI2Cs_bRAM_Buf_WSize
       0009  EzI2Cs_bBusy_Flag
       0009  _EzI2Cs_bBusy_Flag
       000A  _CSD_bNoiseThreshold
       000A  CSD_bNoiseThreshold
       000B  CSD_bNegativeNoiseThreshold
       000B  _CSD_bNegativeNoiseThreshold
       000C  _CSD_bBaselineUpdateThreshold
       000C  CSD_bBaselineUpdateThreshold
       000D  CSD_bHysteresis
       000D  _CSD_bHysteresis
       000E  _CSD_bDebounce
       000E  CSD_bDebounce
       000F  _CSD_bLowBaselineReset
       000F  CSD_bLowBaselineReset
       0010  CSD_bEndOfArray
       0010  _CSD_bEndOfArray
       0011  CSD_fIsPressed
       0011  _CSD_fIsPressed
       0012  _CSD_bCurPos
       0012  CSD_bCurPos
       0013  CSD_bSnsMaskPtr
       0013  _CSD_bSnsMaskPtr
       0017  CSD_wDenom
       0017  _CSD_wDenom
       0019  _CSD_dNumer
       0019  CSD_dNumer
       001B  _CSD_wCtrdPos
       001B  CSD_wCtrdPos
       001D  _CSD_dMultTempX
       001D  CSD_dMultTempX
       0021  _CSD_dMultTempY
       0021  CSD_dMultTempY
       0026  _CSD_bCurCtrdStartPos
       0026  CSD_bCurCtrdStartPos
       0027  CSD_bCurCtrdSize
       0027  _CSD_bCurCtrdSize
       0028  _CSD_bBiggestCtrdStartPos
       0028  CSD_bBiggestCtrdStartPos
       0029  _CSD_bBiggestCtrdSize
       0029  CSD_bBiggestCtrdSize
       002A  _CSD_wCurPkValue
       002A  CSD_wCurPkValue
       002C  _CSD_bCurPkPos
       002C  CSD_bCurPkPos
       002E  _CSD_bDiplexMSB
       002E  CSD_bDiplexMSB
       002F  CSD_bDiplexLSB
       002F  _CSD_bDiplexLSB
       0030  _CSD_wDivBtwSns
       0030  CSD_wDivBtwSns
       0038  CSD_MaxADCValueMSB
       0039  _CSD_wADC_Result
       0039  CSD_wADC_Result
       003B  CSD_bADCStatus
       003B  _CSD_bADCStatus
       003F  CSD_bSensorNum
       003F  _CSD_bSensorNum

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            ram2   0000   0021 =     33. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0048  CSD_baBtnFThreshold
       0048  _CSD_baBtnFThreshold
       0050  CSD_baSnsOnMask
       0050  _CSD_baSnsOnMask
       0051  CSD_baSnsDebounce
       0059  CSD_baLowBaselineReset

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            ram1   0000   0020 =     32. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0061  _CSD_waSnsBaseline
       0061  CSD_waSnsBaseline
       0071  _CSD_waSnsDiff
       0071  CSD_waSnsDiff

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0000   0016 =     22. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __bss_start
       0081  CSD_waSnsResult
       0081  _CSD_waSnsResult
       009A  _CSD_waSliderPrevPos
       009A  CSD_waSliderPrevPos
       009C  _CSD_waSliderCurrPos
       009C  CSD_waSliderCurrPos

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
               virtual_registers   0091   0007 =      7. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0091  __rZ
       0092  __rY
       0093  __rX
       0094  __r3
       0095  __r2
       0096  __r1
       0097  __r0

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0000   000F =     15. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __data_start
       009E  _loopQty
       00A0  _fingerposition
       00A2  _LEDControl_BT
       00A4  _CapSenseControl_Scan
       00A6  _CapSenseControl_Data
       00A8  _LEDControl_RT
       00AA  _LEDControl_GT
       00AC  _CapSensPush

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/capsensecontrol.o	[ capsensecontrol.c ]
obj/ledcontrol.o	[ ledcontrol.c ]
obj/main.o	[ main.c ]
<library>	[ psocconfigtbl.asm, psocconfig.asm, led_red.asm, led_green.asm, led_blue.asm, ezi2csint.asm ]
[ csdtable.asm, csdint.asm, csdhl.asm, csd.asm, rZ.asm, rY.asm, rX.asm, r3.asm, r2.asm, r1.asm, r0.asm ]
[ divmod_16x16_16_util.asm, i_div16_block_util.asm, abs.s ]

Area Definitions

-blit:0x170.0x1fff
-bdata:0.0x100
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0x91
-Bcapsense_RAM
-rwh:SSCParmBlk:0xf7.0xff


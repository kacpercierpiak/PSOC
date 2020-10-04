Project:      output/LED
Build Number: 0
Date:         Mon Jun 01 19:19:57 2020
Compiler:     ICCM8C
Version:      7.05.00


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0170   0048 =     72. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       0170  LoadConfigTBL_capsense_Bank0
       018F  LoadConfigTBL_capsense_Bank1
       01B8  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   01B8   0002 =      2. bytes (rel,con,rom,proclab)

       Addr  Global Symbol
      -----  --------------------------------
       01B8  __func_lit_start
       01BA  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     psoc_config   01BA   00EA =    234. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       01BA  LoadConfigTBL_capsense_Ordered
       023F  LoadConfigInit
       023F  _LoadConfigInit
       0249  LoadConfig_capsense
       0249  _LoadConfig_capsense
       02A4  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   02A4   00B7 =    183. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       02A4  _LED_RED_On
       02A4  LED_RED_On
       02A8  LED_RED_Off
       02A8  _LED_RED_Off
       02A8  LED_RED_Stop
       02A8  LED_RED_Start
       02A8  _LED_RED_Stop
       02A8  _LED_RED_Start
       02AA  LED_RED_Switch
       02AA  _LED_RED_Switch
       02C2  LED_RED_Invert
       02C2  _LED_RED_Invert
       02D1  LED_RED_GetState
       02D1  _LED_RED_GetState
       02E1  LED_GREEN_On
       02E1  _LED_GREEN_On
       02E5  LED_GREEN_Start
       02E5  _LED_GREEN_Start
       02E5  LED_GREEN_Stop
       02E5  _LED_GREEN_Off
       02E5  _LED_GREEN_Stop
       02E5  LED_GREEN_Off
       02E7  _LED_GREEN_Switch
       02E7  LED_GREEN_Switch
       02FF  LED_GREEN_Invert
       02FF  _LED_GREEN_Invert
       030E  _LED_GREEN_GetState
       030E  LED_GREEN_GetState
       031E  _LED_BLUE_On
       031E  LED_BLUE_On
       0322  LED_BLUE_Stop
       0322  _LED_BLUE_Stop
       0322  _LED_BLUE_Off
       0322  _LED_BLUE_Start
       0322  LED_BLUE_Start
       0322  LED_BLUE_Off
       0324  LED_BLUE_Switch
       0324  _LED_BLUE_Switch
       033C  LED_BLUE_Invert
       033C  _LED_BLUE_Invert
       034B  LED_BLUE_GetState
       034B  _LED_BLUE_GetState
       035B  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   035B   0422 =   1058. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       035B  __text_start
       035B  _LEDControl_INIT
       036A  _LEDControl_ChangeState
       03A1  _LEDControl_ChangeStateSwitch
       04BF  _LEDControl_ValueValidation
       0521  _LEDControl_ChangeFrequency
       05EE  _LEDControl_Blink
       06B8  _main
       077D  __text_end
       077D  __xidata_start
       0788  __xidata_end

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
                    InterruptRAM   0000   0001 =      1. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  NO_SHADOW
       0000  _NO_SHADOW
       0000  Port_1_Data_SHADE
       0000  _Port_1_Data_SHADE

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
               virtual_registers   0001   0005 =      5. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0001  __rZ
       0002  __rY
       0003  __rX
       0004  __r1
       0005  __r0

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0000   0006 =      6. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __data_start
       0006  _LEDControl_BT
       0008  _LEDControl_GT
       000A  _LEDControl_RT

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/ledcontrol.o	[ ledcontrol.c ]
obj/main.o	[ main.c ]
<library>	[ psocconfigtbl.asm, psocconfig.asm, led_red.asm, led_green.asm, led_blue.asm, rZ.asm, rY.asm, rX.asm ]
[ r1.asm, r0.asm, mul16_util.asm ]

Area Definitions

-blit:0x170.0x1fff
-bdata:0.0x100
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0x1
-Bcapsense_RAM
-rwh:SSCParmBlk:0xf7.0xff


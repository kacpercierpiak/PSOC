Project:      output/FirstProject
Build Number: 0
Date:         Sat May 30 21:57:39 2020
Compiler:     ICCM8C
Version:      7.05.00


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0170   0060 =     96. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       0170  LoadConfigTBL_firstproject_Bank0
       019B  LoadConfigTBL_firstproject_Bank1
       01D0  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   01D0   0002 =      2. bytes (rel,con,rom,proclab)

       Addr  Global Symbol
      -----  --------------------------------
       01D0  __func_lit_start
       01D2  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     psoc_config   01D2   00E7 =    231. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       01D2  LoadConfigTBL_firstproject_Ordered
       0257  LoadConfigInit
       0257  _LoadConfigInit
       025E  _LoadConfig_firstproject
       025E  LoadConfig_firstproject
       02B9  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   02B9   008E =    142. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       02B9  _PWM8_2_ISR
       02BA  _PWM8_2_EnableInt
       02BA  PWM8_2_EnableInt
       02BE  PWM8_2_DisableInt
       02BE  _PWM8_2_DisableInt
       02C2  _PWM8_2_Start
       02C2  PWM8_2_Start
       02C6  PWM8_2_Stop
       02C6  _PWM8_2_Stop
       02CA  PWM8_2_WritePeriod
       02CA  _PWM8_2_WritePeriod
       02CD  _PWM8_2_WritePulseWidth
       02CD  PWM8_2_WritePulseWidth
       02D0  bPWM8_2_ReadPulseWidth
       02D0  PWM8_2_bReadPulseWidth
       02D0  _PWM8_2_bReadPulseWidth
       02D0  _bPWM8_2_ReadPulseWidth
       02D3  PWM8_2_bReadCounter
       02D3  _PWM8_2_bReadCounter
       02D3  _bPWM8_2_ReadCounter
       02D3  bPWM8_2_ReadCounter
       0300  _PWM8_1_ISR
       0301  PWM8_1_EnableInt
       0301  _PWM8_1_EnableInt
       0305  PWM8_1_DisableInt
       0305  _PWM8_1_DisableInt
       0309  _PWM8_1_Start
       0309  PWM8_1_Start
       030D  _PWM8_1_Stop
       030D  PWM8_1_Stop
       0311  PWM8_1_WritePeriod
       0311  _PWM8_1_WritePeriod
       0314  PWM8_1_WritePulseWidth
       0314  _PWM8_1_WritePulseWidth
       0317  _PWM8_1_bReadPulseWidth
       0317  bPWM8_1_ReadPulseWidth
       0317  PWM8_1_bReadPulseWidth
       0317  _bPWM8_1_ReadPulseWidth
       031A  PWM8_1_bReadCounter
       031A  bPWM8_1_ReadCounter
       031A  _bPWM8_1_ReadCounter
       031A  _PWM8_1_bReadCounter
       0347  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0347   000A =     10. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0347  __text_start
       0347  _main
       0351  __xidata_start
       0351  __text_end
       0353  __xidata_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             TOP   0000   0161 =    353. bytes (abs,ovr,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0068  __Start
       015E  _bGetPowerSetting
       015E  bGetPowerSetting

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
               virtual_registers   0000   0002 =      2. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  __r1
       0001  __r0

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/main.o	[ main.c ]
<library>	[ pwm8_2int.asm, pwm8_2.asm, pwm8_1int.asm, pwm8_1.asm, psocconfigtbl.asm, psocconfig.asm, r1.asm ]
[ r0.asm ]

Area Definitions

-blit:0x170.0x1fff
-bdata:0.0x100
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0
-Bfirstproject_RAM	allocated at: 0
-rwh:SSCParmBlk:0xf7.0xff


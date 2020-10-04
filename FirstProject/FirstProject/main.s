	cpu LMM
	.module main.c
	.area text(rom, con, rel)
	.dbfile ./main.c
	.dbfile C:\Users\100050~1\DOCUME~1\PSOCDE~1.4PR\FIRSTP~1\FIRSTP~1\main.c
	.dbfunc e main _main fV
_main::
	.dbline -1
	.dbline 9
; //----------------------------------------------------------------------------
; // C main line
; //----------------------------------------------------------------------------
; 
; #include <m8c.h>        // part specific constants and macros
; #include "PSoCAPI.h"    // PSoC API definitions for all User Modules
; 
; void main(void)
; {
	.dbline 10
;     PWM8_1_Start();
	push X
	xcall _PWM8_1_Start
	.dbline 11
; 	PWM8_2_Start();
	xcall _PWM8_2_Start
	pop X
	.dbline -2
L1:
	.dbline 0 ; func end
	jmp .
	.dbend

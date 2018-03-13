/*
 * ws2811_driver.S
 *
 * ==================================
 * T0H / T1H
 * ---------|
 * 		    | T0L / T1L
 * 		    |-----------
 * <---- 20 cycles ---->
 *
 * At 16 MHz:	cycles / bit : 20
 * 				cycles / T0H : 7
 * 				cycles / T0L : 13
 * 				cycles / T1H : 12
 * 				cycles / T1L : 8
 * ===================================
 */
#include <avr/io.h>

#define __SFR_OFFSET 0

#define BUFS r22		// 2nd function argument, #leds
#define DATA r18		// Data register
#define BCNT r19        // bit counter

#define PORT PORTB		// GPIO Port
#define PPIN 0			// PORTx bit

.section .text
.global flush

flush:
    mov		XH,	R25
    mov		XL,	R24

    ldi		R23, 3
    mul		BUFS, R23
    mov		BUFS, R0

    ldi     BCNT, 8
    ld      DATA, X+

	cli
next_bit:				; Timings	Pin state
    sbi     PORT, PPIN  ; 2			0
    lsl     DATA        ; 1			1
    brcc    bit_0       ; 1 2		1
bit_1:
	dec		BCNT		; 1			1
	brne	cont_1		; 1 2		1
	dec     BUFS        ; 1			1
	breq	end_1		; 1 2		1
	ld		DATA, X+	; 2			1
    ldi     BCNT, 8		; 1			1
    nop                 ; 1			1
    cbi     PORT, PPIN  ; 2			1
    rjmp	cont_1_2	; 2			0
cont_1:
	nop                 ; 1			1
    rjmp    .+0         ; 2			1
    rjmp    .+0         ; 2			1
    cbi     PORT, PPIN  ; 2			1
    rjmp    .+0         ; 2			0
cont_1_2:
    rjmp    .+0         ; 2			0
    rjmp	next_bit	; 2			0
bit_0:
    rjmp    .+0         ; 2			1
    cbi     PORT, PPIN  ; 2			1
	dec		BCNT		; 1			0
	brne	cont_0		; 1 2		0
	dec		BUFS		; 1			0
	breq	end_0		; 1 2		0
	ld		DATA, X+	; 2			0
	ldi     BCNT, 8		; 1			0
    rjmp    .+0         ; 2			0
	rjmp	next_bit	; 2			0
cont_0:
    rjmp    .+0         ; 2			0
    rjmp    .+0         ; 2			0
    rjmp    .+0         ; 2			0
    rjmp    next_bit    ; 2			0
end_1:
    nop                 ; 1			1
    rjmp    .+0         ; 2			1
	cbi     PORT, PPIN  ; 2			1
end_0:
	sei					;			0
	ret					;			0

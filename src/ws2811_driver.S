/*
 * ws2811_driver.S
 */
#include <avr/io.h>

#define __SFR_OFFSET 0

#define BUFS r22		// 2nd function argument, #leds
#define DATA r18		// Data register
#define PORT PORTB		// GPIO Port
#define PPIN 0			// PORTx bit

#define BCNT r26
.section .text

.global flush

flush:
    cli

    mov		XH,	R25
	mov		XL,	R24

    ldi     R23, 3
    mul     BUFS, R23
    mov     BUFS, R0

next_byte: 				; Timings
;   bit 7
    sbi     PORT, PPIN  ; 2 +
    ld      DATA, X+    ; 2
    lsl     DATA        ; 1
    brcc    b7_0        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b7_0:
    cbi     PORT, PPIN  ; 2 -
    brcs    b7_1        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b7_1:
    rjmp    .+0         ; 2
    nop                 ; 1
    lsl     DATA        ; 1

;   bit 6
    sbi     PORT, PPIN  ; 2 +
    nop                 ; 1
    brcc    b6_0        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b6_0:
    rjmp    .+0         ; 2
    cbi     PORT, PPIN  ; 2 -
    brcs    b6_1        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b6_1:
    rjmp    .+0         ; 2
    nop                 ; 1
    lsl     DATA        ; 1

;   bit 5
    sbi     PORT, PPIN  ; 2 +
    nop                 ; 1
    brcc    b5_0        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b5_0:
    rjmp    .+0         ; 2
    cbi     PORT, PPIN  ; 2 -
    brcs    b5_1        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b5_1:
    rjmp    .+0         ; 2
    nop                 ; 1
    lsl     DATA        ; 1

;   bit 4
    sbi     PORT, PPIN  ; 2 +
    nop                 ; 1
    brcc    b4_0        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b4_0:
    rjmp    .+0         ; 2
    cbi     PORT, PPIN  ; 2 -
    brcs    b4_1        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b4_1:
    rjmp    .+0         ; 2
    nop                 ; 1
    lsl     DATA        ; 1

;   bit 3
    sbi     PORT, PPIN  ; 2 +
    nop                 ; 1
    brcc    b3_0        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b3_0:
    rjmp    .+0         ; 2
    cbi     PORT, PPIN  ; 2 -
    brcs    b3_1        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b3_1:
    rjmp    .+0         ; 2
    nop                 ; 1
    lsl     DATA        ; 1

;   bit 2
    sbi     PORT, PPIN  ; 2 +
    nop                 ; 1
    brcc    b2_0        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b2_0:
    rjmp    .+0         ; 2
    cbi     PORT, PPIN  ; 2 -
    brcs    b2_1        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b2_1:
    rjmp    .+0         ; 2
    nop                 ; 1
    lsl     DATA        ; 1

;   bit 1
    sbi     PORT, PPIN  ; 2 +
    nop                 ; 1
    brcc    b1_0        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b1_0:
    rjmp    .+0         ; 2
    cbi     PORT, PPIN  ; 2 -
    brcs    b1_1        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b1_1:
    rjmp    .+0         ; 2
    nop                 ; 1
    lsl     DATA        ; 1

;   bit 0
    sbi     PORT, PPIN  ; 2 +
    nop                 ; 1
    brcc    b0_0        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b0_0:
    rjmp    .+0         ; 2
    cbi     PORT, PPIN  ; 2 -
    brcs    b0_1        ; 1 2

    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
    rjmp    .+0         ; 2
b0_1:
    dec     BUFS        ; 1
    breq    end         ; 1
    rjmp    next_byte   ; 2
end:
    sei
    ret

;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Lasse Boll
;* Version            : V1.1
;* Date               : 21.04.2026
;* Description        : This is a simple main to setup two LEDs
;                     :
;                     :
;
;*******************************************************************************
    EXTERN initITSboard ; Helper to organize the setup of the board

    EXPORT main         ; we need this for the linker
                        ;- In this context it set the entry point,too

; setup the peripherie - Mapping the GPIO
PERIPH_BASE         equ 0x40000000
AHB1PERIPH_BASE     equ (PERIPH_BASE + 0x00020000)
GPIOD_BASE          equ (AHB1PERIPH_BASE + 0x0C00)
    
GPIO_D_SET          equ (GPIOD_BASE + 0x18)
GPIO_D_CLR          equ (GPIOD_BASE + 0x1A)
    

;* We need minimal memory setup of InRootSection placed in Code Section
    AREA  |.text|, CODE, READONLY, ALIGN = 3
    ALIGN
main
    BL initITSboard             ; needed by the board to setup
    nop                         ; no operation
    LDR     R6, =GPIO_D_SET     ; get address of the GPIO data set register
    LDR     R7, =GPIO_D_CLR     ; get address of the GPIO data clear register
    ;MOV     R0, #0x01           ; load mask 0b0001
    ;MOV     R1, #0x02           ; load mask 0b0010
	MOV		R4, #(0x01+0x02)	; calc mask 1 + 2

    ; Set LED
	STRB	R4, [R6]	; switch on LED D8+D9
    b .
    
    ALIGN
    END

;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Lasse Boll   
;* Version            : V1.0
;* Date               : 25.04.2026
;* Description        : This is a simple main to demonstrate data transfer
;                     : and manipulation.
;                     : 
;
;*******************************************************************************
    EXTERN initITSboard ; Helper to organize the setup of the board

    EXPORT main         ; we need this for the linker - In this context it set the entry point,too

;ConstByteA  EQU 0xaffe
    
;* We need some data to work on
    AREA DATA, DATA, align=2    
VariableA   DCW 0xbeef
VariableB   DCW 0x1234
VariableC   DCW 0xaffe

;* We need minimal memory setup of InRootSection placed in Code Section 
    AREA  |.text|, CODE, READONLY, ALIGN = 3    
    ALIGN   
main
    BL initITSboard             ; needed by the board to setup
;* swap memory - Is there another, at least optimized approach?
    ldr     R0, =VariableA   ; Anw01
    ldrb    R2, [R0]         ; Anw02
    ldrb    R3, [R0,#1]      ; Anw03
    lsl     R2, #8           ; Anw04
    orr     R2, R3           ; Anw05
    strh    R2, [R0]         ; Anw06 
    
;* const in var
    ;mov     R5, #ConstByteA  ; Anw07
    ;strh    R5, [R2]         ; Anw08
    ldr     R5, =VariableC
	ldrb 	R8, [R5]
	ldrb	R9, [R5,#1]
	lsl		R8, #8
	orr		R8, R9
	strh	R8, [R5]
;* Change value from x1234 to x4321
    ldr     R1, =VariableB   ; Anw09
	ldrb	R2, [R1]
	ldrb	R3, [R1,#1]
    lsl     R2, #8
	orr		R2, R3
	strh	R2, [R1]

    ldrh    R6, [R1]         ; Anw0A
    mov     R7, #0x30ED      ; Anw0B
    add     R6, R6, R7       ; Anw0C
    strh    R6, [R1]         ; Anw0D
    b .                      ; Anw0E
    
    ALIGN
    END
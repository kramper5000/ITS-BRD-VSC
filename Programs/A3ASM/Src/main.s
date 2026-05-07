;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base
VariableA          DCW 0x1234
VariableB          DCW 0x4711

VariableC          DCD  0

MeinHalbwortFeld   DCW 0x22 , 0x3e , -52, 78 , 0x27 , 0x45

MeinWortFeld       DCD 0x12345678 , 0x9dca5986
                   DCD -872415232 , 1308622848
                   DCD 0x27000000
                   DCD 0x45000000

MeinTextFeld       DCB "ABab0123",0

                   EXPORT VariableA
                   EXPORT VariableB
                   EXPORT VariableC
                   EXPORT MeinHalbwortFeld
                   EXPORT MeinWortFeld
                   EXPORT MeinTextFeld

;***********************************************
;* Beginn des Programms *
;************************************************
    AREA |.text|, CODE, READONLY, ALIGN = 3
; ----- S t a r t des Hauptprogramms -----
                EXPORT main
                EXTERN initITSboard
main            PROC
                bl    initITSboard                 ; HW Initialisieren

; Laden von Konstanten in Register
;move in r0 konstante 0x12
                mov   r0,#0x12                      ; Anw-01
;move in r0 die konstante -128
                mov   r1,#-128                      ; Anw-02
;load in r2 0x12345678 als pseudo weil zu groß
                ldr   r2,=0x12345678                ; Anw-03

; Zugriff auf Variable
;load in r0 die speicheradresse von VariableA
                ldr   r0,=VariableA                 ; Anw-04
;load halfword 2 byte von der adresse in r0 in r1
                ldrh  r1,[r0]                       ; Anw-05
;load in r2 volle 4 byte von der adresse in r0 an
                ldr   r2,[r0]                       ; Anw-06
;store in r0 mit einem offset von VariableC-VariableA den wert aus r2
                str   r2,[r0,#VariableC-VariableA]  ; Anw-07

; Zugriff auf Felder (Speicherzellen)
;load adresse wo MeinHalbwortFeld beginnt in r0
                ldr   r0,=MeinHalbwortFeld          ; Anw-08
;load halfword 2byte von adresse aus r0 in r1
                ldrh  r1,[r0]                       ; Anw-09
;load halfword von adresse aus r0 mit einem offset von 2 byte in r2
                ldrh  r2,[r0,#2]                    ; Anw-10
;move in r3 konstante 10
                mov   r3,#10                        ; Anw-11
;load halfword in r4 von adresse r0 mit offset von r3(10)
                ldrh  r4,[r0,r3]                    ; Anw-12
;load halfword in r5 von r0 mit einem offset von 2 und writeback r0 um 2
                ldrh  r5,[r0,#2]!                   ; Anw-13
;load halfword in r6 von r0+2 mit einem offset von 2 und writeback r0 um 2
                ldrh  r6,[r0,#2]!                   ; Anw-14
;store r6 in r0+2+2 mit einem offset von 2
                strh  r6,[r0,#2]!                   ; Anw-15

; Addition und Subtraktion von unsigned / signed Integer-Werten
;load in r0 die adresse von MeinWortFeld
                ldr  r0,=MeinWortFeld               ; Anw-16
;load 4byte in r1 von r0 an
                ldr  r1,[r0]                        ; Anw-17
;load 4byte in r2 von r0+4
                ldr  r2,[r0,#4]                     ; Anw-18
;add + setze flags speicher in r3 r1+r2
                adds r3,r1,r2                       ; Anw-19
;load 4byte in r4 r0+8
                ldr  r4,[r0,#8]                     ; Anw-20
;load 4byte in r5+12
                ldr  r5,[r0,#12]                    ; Anw-21
;subtrahiere + setze flags erg in r6 r4-r5
                subs r6,r4,r5                       ; Anw-22
;load 4byte in r7 von r0+16
                ldr  r7,[r0,#16]                    ; Anw-23
;load 4byte in r8 von r0+20
                ldr  r8,[r0,#20]                    ; Anw-24
;subtrahiere erg in r9 r7-r8
                subs r9,r7,r8                       ; Anw-25

forever         b   forever                         ; Anw-26
                ENDP
                END
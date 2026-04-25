VariableA   DCW 0xbeef / 16bit 2 bytes; memory = ef be ...(little endian)
Anw01: load memory adress from VariableA in R0
Anw02: load first byte from memory(with adress R0) in r2 (0xef)
Anw03: load second byte from data(with adress R0) in r3/ by pointing at first byte and giving an offset by 1byte to reach the second byte
Anw04: logical shift left 8bits, so 0xef|-> 0xef00 | 
Anw05: r2 = (r2 or r3)                  |-> 0x00be | = 0xefbe
Anw06: store half word from r2 back in memory r0/ first "be" then "ef" -> memory = be ef
.data
        number_h:   .byte   123
		number_a: 	.space 	5

.text

// ===== HEX to ASCII conversion ===== 
// r0 - address of a hex value variable
// r1 - addrees of a ASCII value variable
 
hex_to_ascii:
        push    {r1, r2, r3, r5, r6, r7, r8, r9, lr}
		ldrb	r8, [r0]
		mov		r9,	r1
		
        @ Initialization for hex to ascii
        mov     r1, r8      @ dividend
        mov     r2, #10     @ divisor
        mov     r5, #0      @ counter

        @ Start conversion with dividing by 10
next_digit:
		udiv	r3, r1, r2
		mul		r7, r3, r2
		sub		r1, r1, r7

        add     r1, r1, #0x30   @ increment by 0x30 to get the ascii value
        push    {r1}            @ push the converted value into the stack
        add     r5, r5, #1      @ increment the counter
        mov     r1, r3          @ update the dividend
        cmp     r3, #0          @ check whether the conversion is finished
        bne     next_digit 

        @ Store the converted value into memory
        mov     r6, r9	
store_asci:
        pop     {r1}            @ pop each digit from the stack
        strb    r1, [r6]        @ store the digit into memory
        add     r6, r6, #1      @ increment the address
        sub     r5, r5, #1      @ decrement the counter
        cmp     r5, #0
        bne     store_asci

        pop     {r1, r2, r3, r5, r6, r7, r8, r9, lr}
        bx      lr

.global main

@ Examples of how to use the hex_to_ascii and ascii_to_hex
@ functions
main:
		ldr		r0, =number_h	@ the first parameter is the address of 
								@ a hex value variable
		ldr		r1, =number_a	@ the second parameter is the address of 
								@ a ASCII value variable that is going
								@ store the results after conversion
        bl hex_to_ascii

		@ exit system call
		mov		r7, #1
		swi 	0

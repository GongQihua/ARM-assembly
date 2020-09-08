.data
count_cap:   .byte 0
count_small: .byte 0
count_digit: .byte 0
count_other: .byte 0
input: .space 40
prompt: .ascii "Input String:\n"

.text
.global main
.macro INC_COUNT var
ldr r8, =\var
ldrb r9, [r8]
add r9, r9, #1
strb r9, [r8]
.endm
main:
	MOV R7, #4
	MOV R0, #1
	MOV R2, #13
	LDR R1, =prompt

	SWI 0

	MOV R7, #3
	MOV R0, #0
	MOV R2, #40
	LDR R1, =input

	SWI 0

	MOV R7, #4
	MOV R0, #1
	MOV R2, #13
	LDR R1, =prompt

	SWI 0

	MOV R7, #4
	MOV R0, #1
	MOV R2, #14
	LDR R1, =input

	SWI 0

	ldr r0, =input
	ldr r1, =0

loop:	ldrb r2, [r0,r1]
	add r1, r1, #1
	cmp r2, #'0'
	blt skip1
	cmp r2, #'9'
	bgt skip1
	INC_COUNT count_digit
	bal end

skip1:	cmp r2, #'A'
	blt skip2
	cmp r2, #'Z'
	bgt skip2
	INC_COUNT count_cap
	bal end

skip2:	cmp r2, #'a'
	blt skip3
	cmp r2, #'z'
	bgt skip3
	INC_COUNT count_small
	bal end

skip3:	cmp r2,#' '
	beq end
	cmp r2,#'	'
	beq end
	INC_COUNT count_other
	bal end

end:	cmp r1, #14
	Blt loop

    @ exit syscall
    mov r7, #1
    swi 0

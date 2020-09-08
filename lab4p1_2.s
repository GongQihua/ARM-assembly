.data
fibonacci:  .byte   1, 1, 0, 0, 0, 0, 0, 0, 0, 0

.text
.global main
main:
        @ Your Program
	ldr r0, =fibonacci
	ldrb r1,=0
	ldrb r5,=0
loop:	ldrb r2,[r0,r1]
	add r1, r1, #1
	ldrb r3,[r0,r1]
	add r4, r2, r3
	add r5, r1,#1
	strb r4, [r0,r5]
	cmp r1, #10
	blt loop
        @ exit syscall
        mov r7, #1
        swi 0 

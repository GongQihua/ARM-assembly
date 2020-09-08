.data
array:  .byte   0, 2, 4, 6, 8, -1, -3, -5, -7

.text
.global main
main:
        @ Your Program
	ldr r0, =array
	ldrsb r1,=0
	ldrsb r3,=0
loop:	ldrsb r2,[r0,r1]
	add r3, r3, r2
	add r1, r1, #1
	cmp r1, #9
	blt loop
        @ exit syscall
        mov r7, #1
        swi 0 

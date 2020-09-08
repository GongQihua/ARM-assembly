.data
array:  .byte -1, 5, 3, 8, 10, 23, 6, 5, 2, -10
size:   .byte 10

.text
.global main

main:
	ldr r0, =array
	ldr r1, =0
	ldr r4, =1
	ldr r6, =0
	ldrsb r5, [r0]
loop:	ldrsb r2, [r0,r1]
	ldrsb r3, [r0,r4]
	cmp r5, r2
	bge skip
	ldrsb r5, [r0,r1]
	mov r6, r1
skip:	cmp r5, r3
	bge jump
	ldrsb r5, [r0,r4]
	mov r6, r4
jump:	add r1, r1, #1
	add r4, r4, #1
	cmp r4, #8
	ble loop
    @ exit syscall
    mov r7, #1
    swi 0

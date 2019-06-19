	.arch armv8-a
	.file	"summation.c"
	.text
	.global	v
	.data
	.align	3
	.type	v, %object
	.size	v, 20
v:
	.hword	5
	.hword	2
	.hword	9
	.hword	6
	.hword	3
	.hword	10
	.hword	7
	.hword	4
	.hword	1
	.hword	8
	.comm	summ,2,2
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	sub	sp, sp, #16
	adrp	x0, summ
	add	x0, x0, :lo12:summ
	strh	wzr, [x0]
	str	wzr, [sp, 12]
	b	.L2
.L3:
	adrp	x0, v
	add	x0, x0, :lo12:v
	ldrsw	x1, [sp, 12]
	ldrh	w1, [x0, x1, lsl 1]
	adrp	x0, summ
	add	x0, x0, :lo12:summ
	ldrh	w0, [x0]
	add	w0, w1, w0
	and	w1, w0, 65535
	adrp	x0, summ
	add	x0, x0, :lo12:summ
	strh	w1, [x0]
	ldr	w0, [sp, 12]
	add	w0, w0, 1
	str	w0, [sp, 12]
.L2:
	ldr	w0, [sp, 12]
	cmp	w0, 9
	ble	.L3
	nop
	add	sp, sp, 16
	ret
	.size	main, .-main
	.ident	"GCC: (GNU Toolchain for the A-profile Architecture 8.3-2019.03 (arm-rel-8.36)) 8.3.0"

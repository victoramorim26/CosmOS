.globl	_start
.text

_start:
.code16
		xorw	%ax, %ax
		movw	%ax, %ds
		movw	%ax, %ss
		movw	%ax, %fs
	
		jmp main

.type		reading, @function
reading:
		movb	$0x00, %ah
		int	$0x16
		movb	$0x0E, %ah
		int	$0x10	

		ret

main:
		call reading
		jmp main
. = _start + 510
.byte		0X55, 0xAA

#Copyright © 2016 - Igor Martinelli, Victor de Aquino Amorim, Zoltan Hirata Jetsmen

#This file is part of CosmOS.

#CosmOS is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.

#CosmOS is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with CosmOS.  If not, see <http://www.gnu.org/licenses/>.
#

.set	MAGIC,	0x1BADB002
.set	FLAGS,	0 | 1
.set	CHECKSUM, -(MAGIC + FLAGS)
.set	STACK_SIZE,	0x4000

.extern kernel_main

.section	.text
.globl	start, _start

start:
_start:
		jmp	multiboot_entry
		.align	4
multiboot_header:
		.long	MAGIC
		.long	FLAGS
		.long	CHECKSUM

multiboot_entry:
		movl	$(stack + STACK_SIZE), %esp
		pushl	$0
		popf
		pushl	%ebx
		pushl	%eax
		call	kernel_main
loop:	hlt
		jmp		loop

		.comm	stack, STACK_SIZE

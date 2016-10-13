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
		int	$0x16		#read syscall.
		movb	$0x0E, %ah	#write on active page.
		int	$0x10		#write syscall.

		ret


.type		clean_screen, @function
clean_screen:
		movb	$0, %ah		#reset video mode
		movb	$2, %al
		int	$0x10		#video syscall

		ret


.type		print_string, @function
print_string:
		mov	$0x0E, %ah	#write on active page.

		string_loop:
			lodsb		#load string byte : move a byte from string to al register and inc si register.
			
			or	%al, %al	#check al and exit if zero.
			jz 	string_exit 	#call exit function.
			
			int	$0x10	#write syscall.
			jmp	string_loop	#call string loop again for write remaining letters.
	
		string_exit:
			ret	#end print_string.


.type		main, @function
main:
		call reading	#call reading and read one character for execute a operation.
		#if character pressed is equal to one, execute clean_screen
		cmp	$'1', %al
		je	exec_clean_screen
		#if character pressed is equal to two, execute print_string, showing bootloader version.
		cmp	$'2', %al
		je	exec_bootloader_version
		
		#jump to main for execute one of the commands again.
		jmp	main
		

		#functions that help execute the operations provided by bootloader.
		exec_clean_screen:
			call clean_screen
			jmp main

		exec_bootloader_version:
			mov	$string, %si		
			call print_string
			jmp main

string: .asciz "CosmOS Bootloader v1.0\n\r" #string that represents the version of bootloader.

. = _start + 510
.byte		0X55, 0xAA

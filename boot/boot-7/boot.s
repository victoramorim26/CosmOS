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


.type		conected_devices, @function
conected_devices:
   		int $0x11       #equipment syscall

                #detect 3 devices using ax

                detect_diskette:
                        mov $0x1, %bx
                        testw %ax, %bx
                        jne hasNotDiskette

                        #bit 0 is set
                        hasDiskette: #print Diskette ON
                                mov $sDisketteOn, %si
                                call print_string
                                jmp detect_ula
                        #bit 0 is not set
                        hasNotDiskette: #print Diskette OFF     
                                mov $sDisketteOff, %si
                                call print_string

                detect_ula:
                        mov $0x2, %bx
                        testw %ax, %bx
                        jne hasNotULA

                        #bit 1 is set
                        hasULA: #print ULA ON
                                mov $sULAOn, %si
                                call print_string
                                jmp detect_point_device
                        #bit 1 is not set
                        hasNotULA: #print ULA OFF
                                mov $sULAOff, %si
                                call print_string

                detect_point_device:
                        mov $0x4, %bx
                        testw %ax, %bx
                        jne hasNotPointDevice
		
			#bit 2 is set
                        hasPointDevice: #print Pointing Device ON
                                mov $sPointingDeviceOn, %si
                                call print_string
                                jmp detect_end
                        #bit 2 is not set
                        hasNotPointDevice: #print Pointing Device OFF
                                mov $sPointingDeviceOff, %si
                                call print_string

                detect_end:
			ret


.type		reboot, @function
reboot:
		int $0x19	#reboot syscall.
		ret


#Move some letter to %al
zero: movb $'0', %al
	ret
one: movb $'1', %al 
	ret
two: movb $'2', %al 
	ret
three: movb $'3', %al 
	ret
four: movb $'4', %al 
	ret
five: movb $'5', %al 
	ret
six: movb $'6', %al 
	ret
seven: movb $'7', %al 
	ret
eight: movb $'8', %al 
	ret
nine: movb $'9', %al 
	ret
a: movb $'A', %al
	 ret
b: movb $'B', %al 
	ret
c: movb $'C', %al 
	ret
d: movb $'D', %al 
	ret
e: movb $'E', %al 
	ret
f: movb $'F', %al
	 ret

#Compare the binary number to print the correct hexadecimal number
.type		compare, @function
compare:
		cmp $0x0, %bh
		je zero
		cmp $0x1, %bh
		je one
		cmp $0x2, %bh
		je two
		cmp $0x3, %bh
		je three
		cmp $0x4, %bh
		je four
		cmp $0x5, %bh
		je five
		cmp $0x6, %bh
		je six
		cmp $0x7, %bh
		je seven
		cmp $0x8, %bh
		je eight
		cmp $0x9, %bh
		je nine
		cmp $0xA, %bh
		je a
		cmp $0xB, %bh
		je b
		cmp $0xC, %bh
		je c
		cmp $0xD, %bh
		je d
		cmp $0xE, %bh
		je e
		cmp $0xF, %bh
		je f

		ret

.type		amount_ram, @function
amount_ram:
		
		int $0x12 #return the amount of ram in register %ax
		#Separe de %ax in two parts
		movb %al, %ch 
		movb %ah, %cl
		
		#Do the same thing four time:
		#Read four bytes per time and transform the binary number in a hexadecimal number
		movb $0xf0, %bh
		andb %cl, %bh
		shrb $0x4, %bh
		call compare
		
		movb $0x0e, %ah
		int $0x10 #Print %al

		movb $0xf, %bh
		andb %cl, %bh
		call compare
		
		movb $0x0e, %ah
		int $0x10

		movb $0xf0, %bh
		andb %ch, %bh
		shrb $0x4, %bh
		call compare
		
		movb $0x0e, %ah
		int $0x10

		movb $0xf, %bh
		andb %ch, %bh
		call compare

		movb $0x0e, %ah
		int $0x10

		xorw %ax, %ax
		movb $0x0d, %al # Return to the begin of the line
		movb $0x0e, %ah
		int $0x10
		
		xorw %ax, %ax
		movb $0x0a, %al #Next line
		movb $0x0e, %ah
		int $0x10	
		
		ret


.type		main, @function
main:
		call reading	#call reading and read one character for execute a operation.
		#if character pressed is equal to one, execute clean_screen
		cmp	$'1', %al
		je	exec_clean_screen
		#if character pressed is equal to two, execute print_string, showing bootloader version.
		cmp	$'2', %al
		je	exec_bootloader_version
		#if character pressed is equal to three, shows three conected_devices.
		cmp	$'3', %al
		je	exec_conected_devices
		#if character pressed is equal to four, reboot the bootloader.
		cmp	$'4', %al
		je	exec_reboot
		#if character pressed is equal to five, show amount of ram in real mode.
		cmp	$'5', %al
		je	exec_amount_ram

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

		exec_conected_devices:
			call conected_devices
			jmp main

		exec_reboot:
			call reboot
			jmp main
		
		exec_amount_ram:
			call amount_ram
			jmp main	

string: .asciz "CosmOS Bootloader v1.0\n\r" #string that represents the version of bootloader.
sDisketteOn: .asciz "Diskette: ON\n\r"
sDisketteOff: .asciz "Diskette: OFF\n\r"
sULAOn: .asciz "ULA: ON\n\r"
sULAOff: .asciz "ULA: OFF\n\r"
sPointingDeviceOn: .asciz "Pointing Device: ON\n\r"
sPointingDeviceOff: .asciz "Pointing Device: OFF\n\r"

. = _start + 510
.byte		0X55, 0xAA

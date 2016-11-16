#
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

all:
	as --32 boot.s -o boot.o
	gcc -m32 -c video/drive.c
	gcc -m32 -c kernel_main.c
	gcc -m32 -c libc/src/*.c -fno-stack-protector
	ld -m elf_i386 -T linker.ld -o kernel.bin *.o
	grub-file --is-x86-multiboot ./kernel.bin
	cp kernel.bin isodir/boot
	grub-mkrescue -o kernel.iso isodir
	qemu-system-i386 -cdrom kernel.iso

clean:
	rm ./*.bin ./*.o *.iso
	rm isodir/boot/*.bin

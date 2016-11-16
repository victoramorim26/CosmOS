/*
Copyright © 2016 - Igor Martinelli, Victor de Aquino Amorim, Zoltan Hirata Jetsmen

This file is part of CosmOS.

CosmOS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

CosmOS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with CosmOS.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "../../video/drive.h"
#include "../include/stdarg.h"
#include "../include/stdio.h"

int putchar(int c) {
	unsigned char aux = (unsigned char) c;
	
	writeChar(aux);
	
	return aux;
}

int puts(const char *str) {
	int i = 0;
	
	while(str[i]) putchar(str[i++]);
}

void i2a(int integer) {
	char converted[16];
	int i = 0;

	while(integer > 0) {
		converted[i++] = '0'+(integer%10);
		integer /= 10;
	}
	converted[i] = '\0';

	for(i; i >= 0; i--) putchar((int)converted[i]);
}

void i2bin(int integer) {
	int digit = integer%2;

	if(integer >= 2) i2bin(integer /= 2);
	putchar(digit+'0');
}

void i2hex(int integer) {
	int digit = integer%16;

	if(integer >= 16) i2hex(integer /= 16);
	if(digit < 10) putchar(digit+'0');
	else putchar((digit%10)+'A');
}

int print(va_list va, const char *format) {
	int result, i = 0;

	while(format[i]) {
		if(format[i] == '%') {
			switch(format[++i]) {
				case 'd':
					i2a((int)va_arg(va, char *));
					break;
				case 'c':
					putchar((int)va_arg(va, char *));
					break;
				case 's':
					puts(va_arg(va, char *));
					putchar('\n');
					break;
				case 'x':
				case 'X':
					i2hex((int)va_arg(va, char *));
					break;
				case 'b':
					i2bin((int)va_arg(va, char *));
					break;
			}
		} else 	
			putchar(format[i]);
		i++;
	}

	return result;
}

int printf(const char *format, ...) {
	va_list va;
	int result;

	va_start(va, format);
	result = print(va, format);
	va_end(va);
	
	return result;
}

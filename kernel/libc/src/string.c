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

#include "../include/string.h"

int strlen(const char * s){

	int i = 0;

	while(s[i] != '\0') i++;

	return i;
}

char * strcpy(char *dest, const char *src){

	int i = 0;

	while(src[i] != '\0'){
		dest[i] = src[i];
		i++;
	}

	dest[i] = '\0';

	return dest;
}

int strcmp(const char *s1, const char *s2){

	for(; *s1 == *s2; s1++, s2++){
		if(*s1 == '\0') return 0;
	}
	
	if(*(unsigned char*)s1 > *(unsigned char*)s2) return 1;
	else return -1;
}

void * memcpy(void * dest, const void * src, int n){

    char *d = (char*)dest;
    const char *s = (char*)src;
 
   	while(n--){
        *d = *s;
        d++; s++;
    }
   
    return dest;
}

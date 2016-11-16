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

#ifndef _STRING_H_
#define _STRING_H_

int strlen(const char * s);

char * strcpy(char *dest, const char *src);

int strcmp(const char *s1, const char *s2);

void * memcpy(void * dest, const void * src, int n);

#endif
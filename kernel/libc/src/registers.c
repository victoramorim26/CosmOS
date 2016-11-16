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

#include "../include/stdio.h"

int get_cs_register(){
	int cs = 0;

	__asm__ __volatile__
	(
	 	"movw %%cs, %%ax\n\t;"	 	
		: "=a"(cs)
	);

	return cs;
}

int get_ds_register(){
	int ds = 0;

	__asm__ __volatile__
	(
	 	"movw %%ds, %%ax\n\t;"	 	
		: "=a"(ds)
	);

	return ds;
}

int get_ss_register(){
	int ss = 0;

	__asm__ __volatile__
	(
	 	"movw %%ss, %%ax\n\t;"	 	
		: "=a"(ss)
	);

	return ss;
}
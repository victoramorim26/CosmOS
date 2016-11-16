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

#include "video/drive.h"
#include "libc/include/stdio.h"
#include "libc/include/registers.h"

void kernel_main(){

	initializeDriver();

	printf("Welcome to CosmOS\n\n");
	printf("Value of cs register: %d\n", get_cs_register());
	printf("Value of ds register: %d\n", get_ds_register());
	printf("Value of ss register: %d\n", get_ss_register());

	while(1);

}

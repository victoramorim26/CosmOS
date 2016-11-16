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

#include "drive.h"

unsigned char *vga_addr;
int posX;
int posY;

void initializeDriver(){

	vga_addr = (unsigned char*)0xB8000;
	posY = 0;
	posX = 0;

}

void writeChar(unsigned char c){

	int position;

	if(c == '\n'){
		posY = posY + 160;
		posX = 0;
	}
	else{
		position = posY + (posX);
		vga_addr[position] = c;
		posX = posX + 2;
	}

	if(posX == 160){
		posX = 0;
		posY = posY + 160;
	}

	if(posY >= 160*25){
		cleanScreen();
		posY = 0;
		posX = 0;
	}
}

void cleanScreen(){

	int i;

	for(i = 0; i < 160*25; i = i + 2) vga_addr[i] = ' ';

	posX = 0;
	posY = 0;
}
//****************************************************************************************************************************
//Program name: "Triangles".  This program calculate the triangles's legth of the last side after get user input: two sides' *
//legth and the angle between the sides. Also this program has input validaion for float input.                    			 *
//Copyright (C) 2024 Minjae Kim                                  															 *
//                                                                                                                           *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
//but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
//the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
//<https://www.gnu.org/licenses/>.                                                                                           *
//****************************************************************************************************************************

//Author: Minjae Kim
//Author email: gorgeous9802@csu.fullerton.edu
//Author CWID: 885206615
//Author class: CPSC240-09
//Assignment due date : 2024-Feb-24

//Program name: Triangles
//Programming languages: One module in C, two in X86, and one in bash.
//Date program began: 2024-Feb-15
//Date of last update: 2024-Feb-24
//Files in this program: driver.c, triangles.asm, isfloat.asm,r.sh.
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  Calculate triangle's length of last side with two sides' length and the angle between them.

//This file
//  File name: driver.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc  -m64 -Wall -no-pie -o driver.o -std=c2x -c driver.c -lm
//  Link: gcc -m64 -no-pie -o triangles.out isfloat.o triangles.o driver.o -std=c2x -Wall -z noexecstack -lm

#include <stdio.h>
#include <math.h>

extern double triangles();

int main(int argc, const char* argv[])
{
	printf("Welcome to Amazing Triangles programmed by Minjae Kim on February 24, 2024.\n");
	double third_side = 0.0;
	third_side = triangles();
	printf("\nThe driver has received this number %1.10lf and will simply keep it.\n", third_side);
	printf("An integer zero will now be sent to the operating system.   Bye\n");

	return 0;
}

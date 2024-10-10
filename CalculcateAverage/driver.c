//****************************************************************************************************************************
//Program name: "Average Speed".  This program calculate the total distance, total time, and average speed of traveling of   *
//users who travel from Fullerton to Santa Ana, Santa Ana to Long Beach, and Long beach to Fullerton. This calculation tool  *
//helps users who have traveled chart their travel history. Copyright (C) 2024  Minjae Kim.                                  *
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

//Program name: Average Speed
//Programming languages: One module in C, one in X86, and one in bash.
//Date program began: 2024-Feb-1
//Date of last update: 2024-Feb-4
//Files in this program: driver.c, average.asm, r.sh.
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program chart travel history information from Fullerton to Santa Ana and Long Beach.

//This file
//  File name: driver.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc -m64 -no-pie -o average.o -std=c2x -Wall average.c -c
//  Link: gcc -m64 -no-pie -o average.out average.o -std=c2x -Wall -z noexecstack



#include <stdio.h>
//#include <string.h>
//#include <stdlib.h>

extern double average();

int main(int argc, const char* argv[])
{
	printf("Welcome to Average Speed maintained by Minjae Kim\n");
	double count = 0;
	count = average();
	printf("The driver has received this number %1.8lf and will keep it for future use. Have a great day.\n", count);
	printf("I hope you enjoyed your first lesson in assembly programming.\n");
	printf("Have a nice day.\n\n");
	printf("A zero will be sent to the operating system as a signal of a successful execution.\n");

	return 0;
}

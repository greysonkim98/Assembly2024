//****************************************************************************************************************************
//Program name: "Arrays". This program calculate the variance of the user float inputs   									 *
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
//Assignment due date : 2024-Mar-18

//Program name: Arrays
//Programming languages: One module in C, two in X86, and one in bash.
//Date program began: 2024-Mar-10
//Date of last update: 2024-Mar-15
//Files in this program: input_array.asm isfloat.asm manager.asm main.c compute_variance.cpp output_array.c  compute_mean.asm
//						 r.sh rg.sh
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  Calculate the variance of float elements in the arrays 

//This file
//  File name: main.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c -lm
//  Link: g++ -m64 -no-pie -o Array.out input_array.o isfloat.o manager.o main.o compute_variance.o output_array.o 
//		  compute_mean.o -std=c++11 -Wall -z noexecstack -lm

#include <stdio.h>
#include <math.h>

extern double manager();

int main(int argc, const char* argv[])
{
	printf("Welcome to Arrays of floating point numbers.\n");
    printf("Bought to you by Minjae Kim.\n");
	double mean = 0.0;
	mean = manager();
	printf("\nMain recived %1.10lf and will simply keep it for future use.\n", mean);
	printf("Main will return 0 to the operating system.   Bye.\n");

	return 0;
}

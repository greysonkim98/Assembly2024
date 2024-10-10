//****************************************************************************************************************************
//Program name: "Non-deterministic Random Numbers". This program generate randime number 									 *
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

//Program name: Non-deterministic Random Numbers
//Programming languages: One module in C, two in X86, and one in bash.
//Date program began: 2024-Mar-10
//Date of last update: 2024-Mar-15
//Files in this program: executive.asm isnan.asm fill_random_array.asm main.c sort.cpp normalize_array.asm r.sh
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  Calculate the variance of float elements in the arrays 

//This file
//  File name: main.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc -c -m64 -Wall -fno-pie -no-pie -o main.o main.c -std=c17
//  Link: g++ -m64 -no-pie -o hw5.out -std=c++11 show_array.o sort.o main.o executive.o fill_random_array.o
//		   isnan.o normalize_array.o

#include <stdio.h>

extern char* executive();

int main(int argc, const char* argv[])
{
	printf("Welcome to Random Products, LLC.\n");
    printf("This software is maintained by Minjae Kim\n");
	char *name = executive();
	printf("Oh, %s.  We hope you enjoyed your arrays.  Do come again.\n", name);
	printf("A zero will be returned to the operating system.\n");

	return 0;
}

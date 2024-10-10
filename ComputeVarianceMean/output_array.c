//****************************************************************************************************************************
//Program name: "Output Array". This a library function contained in a single file. This program receive the adress of       *
//the array, the size of the array, and display all elements in the array                                                    *
//Copyright (C) 2024 Minjae Kim                                                                                              *
//                                                                                                                           *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
//but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
//the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
//<https://www.gnu.org/licenses/>.                                                                                           *
//****************************************************************************************************************************

//Author information
//   Author name: Minjae Kim
//   Author email: gorgeous9802@csu.fullerton.edu
//   Author CWID: 885206615
//   Author class: CPSC240-09
//   Assignment due date : 2024-Mar-18
// 
//function information
//  Program name: output_array
//  Programming languages: C
//  Date program began: 2024-Mar-10
//  Date of last update: 2024-Mar-15
//  Files in this program: output_array.c
//  Compiler used for testing: gcc version 11.4.0
//  Prototype:double output_array(double* ,long);
//
//Purpose
//  This function wil calculate the mean which can be converted to a corresponding 64-bit 
//
//
//Translation information
//  compile command: gcc  -m64 -Wall -no-pie -o output_array.o -std=c2x -c output_array.c
//

//========= Begin source code ====================================================================================
#include <stdio.h>

//Display double in array
void output_array(double *myarray,long count)
{   
    for (int i = 0; i < count; i++)
    {
        printf("%1.5lf\n", (myarray[i]));
    }
}
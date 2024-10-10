//****************************************************************************************************************************
//Program name: "sort". This a library function contained in a single file. This program perform bubble sort                 *
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
//  Program name: sort
//  Programming languages: C++
//  Date program began: 2024-Mar-10
//  Date of last update: 2024-Mar-15
//  Files in this program: sort.cpp
//  Compiler used for testing: gcc version 11.4.0
//  Prototype:double sort(long* ,long);
//
//Translation information
//  compile command: g++  -m64 -Wall -no-pie -o sort.o -std=c++11 -c sort.cpp 
//
//========= Begin source code ====================================================================================
#include <iostream>

extern "C" void sort(long* arr,long size);

//bubblesort  
void sort(long *arr, long size) {
    for (int i = 0; i < size - 1; ++i) {
        for (int j = 0; j < size - i - 1; ++j) {
            if (arr[j] > arr[j + 1]) {
                // Swap arr[j] and arr[j+1]
                long temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}
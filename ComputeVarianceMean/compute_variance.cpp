//****************************************************************************************************************************
//Program name: "Compute variance". This a library function contained in a single file. This program receive the adress of   *
//the array, the size of the array and the mean of the number it contains, and generate variance.                            *
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
//  Program name: compute_variance
//  Programming languages: C++
//  Date program began: 2024-Mar-10
//  Date of last update: 2024-Mar-15
//  Files in this program: compute_variance.cpp
//  Compiler used for testing: gcc version 11.4.0
//  Prototype:double compute_variance(double* ,long , double);
//
//Purpose
//  This function wil accept a array of float and calculate the mean which can be converted to a corresponding 64-bit 
//
//
//Translation information
//  compile command: g++  -m64 -Wall -no-pie -o compute_variance.o -std=c++11 -c compute_variance.cpp 
//

//========= Begin source code ====================================================================================

#include <iostream>
#include <math.h>

extern "C" double compute_variance(double* arr,long size, double mean);

//compute variance 
double compute_variance(double* arr,long size, double mean) {
    double variance = 0.0;
    for (int i = 0; i < size; ++i) {
        variance += (arr[i] - mean) * (arr[i] - mean);
    }
    return variance / size;
}
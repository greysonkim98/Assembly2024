// Program Nmae: Area of Trianlges 
//
//Author: Minjae Kim
//Author email: gorgeous9802@csu.fullerton.edu
//Author CWID: 885206615
//Author class: CPSC240-09
//Assignment due date : 2024-May-12
//
//Program name: Triangles
//Programming languages: One module in C, two in X86, and one in bash.
//Date program began: 2024-May-4
//Date of last update: 2024-May-11
//Files in this program: driver.c, triangles.asm, isfloat.asm,r.sh.
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  Calculate triangle's length of last side with two sides' length and the angle between them.
//
//This file
//  File name: director.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc  -m64 -Wall -no-pie -o director.o -std=c2x -c director.c
//  Link: g++ -m64 -no-pie -o hm5.out sin.o producer.o director.o -std=c++11 -Wall -z noexecstack

#include <stdio.h>

extern double producer();
extern void ftoa();

void ftoa(double n) 
{ 
    printf("\nThe area of this triangle is %1.5lf square feet.\n", n);
}

int main(int argc, const char* argv[])
{
	printf("Welcome to Marvelous Minjae’s Area Machine.\n");
    printf("We compute all your areas.\n");
	double area = producer();
	printf("\n\nThe driver received this number %1.5lf and will keep it\n", area);
	printf("A zero will be sent to the OS as a sign of successful conclusion.\n");
    printf("Bye\n");

	return 0;
}

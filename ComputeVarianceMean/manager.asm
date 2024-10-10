;****************************************************************************************************************************
;Program name: "Arrays". This program calculate the variance of the user float inputs                                       *   
;;Copyright (C) 2024 Minjae Kim                                                                                             *
;                                                                                                                           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
;<https://www.gnu.org/licenses/>.                                                                                           *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Minjae Kim
;  Author email: gorgeous9802@csu.fullerton.edu
;  Author CWID: 885206615
;  Author class: CPSC240-09
;  Assignment due date : 2024-Mar-18
;
;Program information
;  Program name: Arrays
;  Programming languages: One module in C, two in X86, and one in bash.
;  Date program began: 2024-Mar-10
;  Date of last update: 2024-Mar-15
;  Files in this program: input_array.asm isfloat.asm manager.asm main.c compute_variance.cpp output_array.c compute_mean.asm
;                           r.sh rg.sh
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  Calculate the variance of float number
;
;This file:
;  File name: manager.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -l manager.lis -o manager.o manager.asm
;  or nasm -f elf64 -l manager.lis -o manager.o manager.asm
;  Assemble (debug): nasm -g dwarf -l manager.lis -o manager.o manager.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: double manager();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
global manager

extern printf
extern stdin
extern compute_mean
extern input_array
extern compute_variance
extern output_array

null equ 0
true equ -1
false equ 0
array_size equ 48

segment .data

    promt_intro1 db "This program will manage your arrays of 64-bit floats" ,10,0
    promt_intro2 db "For the array enter a sequence of 64-bit floats separated by white space." ,10,0
    promt_intro3 db "After the last input press enter followed by Control+D: ",10,0
    
    format_float db "%lf", 0
    format_string db "%s", 0
    prompt_tryagain db "try again",0 

    promt_element db "These numbers were received and placed into an array" ,10,0
    promt_variance db "The variance of the inputted numbers is %1.6lf",10,0

segment .bss

    align 64
    storedata resb 832
    array resq array_size
segment .text

manager:

;Back up the GPRs (General Purpose Registers)
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

;Back up everthingi nsdie xmm0 - xmm15
mov     rax, 7
mov     rdx, 0
xsave   [storedata]

;Dispay promt of intruction of the program
mov rax,0
mov rdi, promt_intro1
call printf
mov rax,0
mov rdi, promt_intro2
call printf
mov rax,0
mov rdi, promt_intro3
call printf

;Obtain user input
mov rax, 0
mov rdi, array
mov rsi, array_size
call input_array
mov r15, rax ;r15 contain the number of the element in array

;Dispaly array inputted 
mov rax, 0
mov rdi, promt_element
call printf
mov rax, 0
mov rdi, array
mov rsi, r15
call output_array

;Obtain mean number
mov rax, 0
mov rdi, array
mov rsi, r15
call compute_mean
movsd xmm14, xmm0 ; xmm14 contains the mean

;Obtain variance
mov rax,1
mov rdi, array
mov rsi, r15
movsd xmm0, xmm14
call compute_variance
movsd xmm13, xmm0 ;xmm13 contains variance

;Display variance of the inputted numbers 
mov rax, 1
mov rdi, promt_variance
movsd xmm0, xmm13
call printf

;'Save' the result onto the stack
push    qword 0
movsd   [rsp], xmm13

; Restore all the floating-point numbers
mov     rax, 7
mov     rdx, 0
xrstor  [storedata]

; Retrieve the result from the stack
movsd   xmm0, [rsp]
pop     rax

popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp   ;Restore rbp to the base of the activation record of the caller program
ret
;End of the function average ====================================================================

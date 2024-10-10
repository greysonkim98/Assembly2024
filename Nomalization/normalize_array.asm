;Program name: "normalize_array". This a library function contained in a single file. This function modifies the elements 
;in the array to be in range between 1 and 2.
;Copyright (C) 2024 Minjae Kim                                                                                              
;                                                                                                                          
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             
;<https://www.gnu.org/licenses/>.                                                                                          
;
;Author information
;   Author name: Minjae Kim
;   Author email: gorgeous9802@csu.fullerton.edu
;   Author CWID: 885206615
;   Author class: CPSC240-09
;   Assignment due date : 2024-Apr-15
; 
;function information
;  Program name: normalize_array
;  Programming languages: X86 assmebly in Intel syntax
;  Date program began: 2024-Apr-11
;  Date of last update: 2024-Apr-13
;  Files in this program: normalize_array.asm
;  System requirements: an X86 platform with nasm installed o other compatible assembler.
;  Compiler used for testing: nasm version 2.15.05
;  Prototype:void normalize_array(long*, long)
;
;Translation information
;  compile command: nasm -f elf64 -l normalize_array.lis -o normalize_array.o normalize_array.asm
;
;
;========= Begin source code ====================================================================================
global normalize_array
extern rdrand

segment .data
    ;empty
segment .bss
    align 64
    storedata resb 832
segment .text
normalize_array:
; Back up components
push        rbp
mov         rbp, rsp
push        rbx
push        rcx
push        rdx
push        rsi
push        rdi
push        r8 
push        r9 
push        r10
push        r11
push        r12
push        r13
push        r14
push        r15
pushf

; Save all the floating-point numbers
mov         rax, 7
mov         rdx, 0
xsave       [storedata]

xor         r13, r13                        ; r13 keeps track of the index of the loop 
mov         r14, rdi                        ; rdi contains the address of the random_number_array   
mov         r15, rsi                        ; rsi contains the count of the random_number_array

normalize_loop:
; If the index reach the count, end the loop
cmp         r13, r15
jge         normalize_finished

; Normalize an element of the array
mov         r12, [r14 + r13 * 8]            ; Temporary copy the element into r12.                  0x9c75b07eadac83b9 
shl         r12, 12                         ; Shift the hex number 3 place to the left.             0x5b07eadac83b9 
shr         r12, 12                         ; Shift the hex number 3 place to the right.            0x0005b07eadac83b9 
mov         rax, 0x3FF0000000000000          
or          r12, rax                        ; OR the hex number with the mask
mov         [r14 + r13 * 8], r12            ; Move the normalized hex number back into the array    0x3ff5b07eadac83b9

; Inrease the index and repeat the loop
inc         r13      
jmp         normalize_loop

normalize_finished:
; Restore all the floating-point numbers
mov         rax, 7
mov         rdx, 0
xrstor      [storedata]

;Restore the original values to the GPRs
popf          
pop         r15
pop         r14
pop         r13
pop         r12
pop         r11
pop         r10
pop         r9 
pop         r8 
pop         rdi
pop         rsi
pop         rdx
pop         rcx
pop         rbx
pop         rbp

; Clean up
ret
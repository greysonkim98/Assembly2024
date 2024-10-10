;Program name: Area of Triangles
;
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
;<https://www.gnu.org/licenses/>.  
;
;Author information
;  Author name: Minjae Kim
;  Author email: gorgeous9802@csu.fullerton.edu
;  Author CWID: 885206615
;  Author class: CPSC240-09
;  Assignment due date : 2024-May-12
;
;Program information
;  Program name: Area of Triangles
;  Programming languages: One module in C, two in X86, and one in bash.
;  Date program began: 2024-May-12
;  Date of last update: 2024-May-12
;  Files in this program: director.c, producer.asm, sin.asm, r.sh.
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  Calculate triangle's length of last side with two sides' length and the angle between them.
;
;This file:
;  File name: producer.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -l producer.lis -o producer.o producer.asm
;  or nasm -f elf64 -l producer.lis -o producer.o producer.asm
;  Assemble (debug): nasm -g dwarf -l producer.lis -o producer.o producer.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: double producer();
; 
global producer

extern atof
extern ftoa
extern sin


segment .data
    prompt_length1 db "Please enter the length of side 1:  ", 10 ,0
    prompt_length2 db "Please enter the length of side 2:  ", 10 ,0
    prompt_angle db "Please enter the degrees of the angle between:  ", 10, 0

    prompt_end db "Thanks for using MJ's product.", 10, 0

    two dq 2.0

segment .bss
    align 64
    storedata resb 832
    length1   resb 255  ; Buffer to store user input
    length2   resb 225
    angle     resb 225
    area      resb 32
segment .text

producer:
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

; Prompt the instruction and Obtain two legnths and one angle from a user
mov rax, 1
mov rdi, 1
mov rsi, prompt_length1
mov rdx, 36
syscall

mov rax, 0
mov rdi, 0
mov rsi, length1
mov rdx, 255
syscall

mov rax, 1
mov rdi, 1
mov rsi, prompt_length2
mov rdx, 36
syscall

mov rax, 0
mov rdi, 0
mov rsi, length2
mov rdx, 255
syscall

mov rax, 1
mov rdi, 1
mov rsi, prompt_angle
mov rdx, 48
syscall

mov rax, 0
mov rdi, 0
mov rsi, angle
mov rdx, 255
syscall

mov rax, 0 
mov rdi, length1
call atof
movsd xmm11, xmm0 ;xmm11 contains length1 

mov rax, 0 
mov rdi, length2
call atof
movsd xmm12, xmm0 ; xmm12 contains length2 

mov rax, 0
mov rdi, angle
call atof
movsd xmm13, xmm0 ; xmm13 contains angle 

movsd xmm0, xmm13
call sin
movsd xmm13, xmm0 ; xmm13 contains sin angle

movsd xmm14, xmm11
mulsd xmm14, xmm12
divsd xmm14, qword[two]
mulsd xmm14, xmm13 ; xmm13 contains triangle area

movsd xmm0, xmm14   ; xmm0 contains area

; Convert area float into string and print 
call ftoa

; Display end prompt
mov rax, 1
mov rdi, 1
mov rsi, prompt_end
mov rdx, 30
syscall

;'Save' the result onto the stack
push    qword 0
movsd   [rsp], xmm14

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
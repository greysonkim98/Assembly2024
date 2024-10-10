;****************************************************************************************************************************
;Program name: "Average Speed".  This program calculate calculate the total distance, total time, and average speed of      *
;traveling of users who travel from Fullerton to Santa Ana, Santa Ana to Long Beach, and Long beach to Fullerton. This      *
;assembly, link, and execute a program containing source code written in X86.  Copyright (C) 2024  Minjae Kim               *
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
;
;Program information
;  Program name: Average Speed
;  Programming languages: One module in C, one in X86, and one in bash.
;  Date program began: 2024-Feb-1
;  Date of last update: 2024-Feb-3
;  Files in this program: driver.c, average.asm, r.sh.  At a future date rg.sh may be added.
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program is a starting point for those learning to program in x86 assembly. 
;
;This file:
;  File name: average.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -l average.lis -o average.o average.asm
;  or nasm -f elf64 -l average.lis -o average.o average.asm
;  Assemble (debug): nasm -g dwarf -l average.lis -o average.o average.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: double average();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**


extern printf

extern scanf

extern fgets

extern stdin

extern strlen

global average

name_string_size equ 48

title_string_size equ 48

segment .data

get_name db "Please enter your first and last names:   ", 0
get_title db "Please enter your title such as Lieutenant, Chief, Mr, Ms, Influencer, Chairman, Freshman, Foreman, Project Leader, etc:  ",0
msg_thank db "Thank you %s %s", 10, 0

get_miles_FS db 10,"Enter the number of miles traveled from Fullerton to Santa Ana: ",0
get_miles_SL db 10,"Enter the number of miles traveled from Santa Ana to Long Beach: ",0
get_miles_LF db 10,"Enter the number of miles traveled from Long Beach to Fullerton: ",0
get_speed db "Enter your average speed during that leg of the trip: ",0

msg_procss db 10,"The inputted data are being processed",10,10,0

msg_distance db "The total distance traveled is %1.8lf miles", 10,0
msg_time db "The time of the trip is  %1.8lf hours",10,0
msg_speed db "The average speed during this trip is %1.8lf mph.",10,10,0

float_form db "%lf", 0
total_distance dq 0.0
total_avg dq 0.0
total_time dq 0.0

segment .bss

name resb name_string_size
title resb title_string_size

segment .text

average:

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

;Print the get_name prompt
mov rax, 0
mov rdi, get_name
call printf

;Input user names
mov rax, 0
mov rdi, name
mov rsi, name_string_size
mov rdx, [stdin]
call fgets

;print the get_title prompt
mov rax, 0
mov rdi, get_title
call printf

;Input user title
mov rax, 0
mov rdi, title
mov rsi, title_string_size
mov rdx, [stdin]
call fgets

;remove newline after title
mov rax, 0
mov rdi, title
call strlen
mov [title + rax-1], byte 0

;remove newline after name
mov rax, 0
mov rdi, name
call strlen
mov [name + rax-1], byte 0

;print thank you followed by the name and title
mov rax, 0
mov rdi, msg_thank
mov rsi, title
mov rdx, name
call printf

;print prompt and get miles from Fullerton to Santa Ana
mov rax, 0
mov rdi, get_miles_FS
call printf
mov rax, 0
mov rdi, float_form
push qword 0
push qword 0
mov rsi, rsp
call scanf
movsd xmm10, qword[rsp] ;xmm10 contains FS_mile
pop rax
pop rax


;print prompt and get speed from Fullerton to Santa Ana
mov rax, 0
mov rdi, get_speed
call printf

mov rax, 0
mov rdi, float_form
push qword 0
push qword 0
mov rsi, rsp
call scanf
movsd xmm13, qword[rsp]; xmm14 contains FS_speed
pop rax
pop rax


;print prompt and get miles from Santa Ana to Long Beach
mov rax, 0
mov rdi, get_miles_SL
call printf
mov rax, 0
mov rdi, float_form
push qword 0
push qword 0
mov rsi, rsp
call scanf
movsd xmm11, qword[rsp]; xmm11 contains SL_mile
pop rax
pop rax


;print prompt and get speed from Santa Ana to Long Beach
mov rax, 0
mov rdi, get_speed
call printf
mov rax, 0
mov rdi, float_form
push qword 0
push qword 0
mov rsi, rsp
call scanf
movsd xmm14, qword[rsp]; xmm14 contains SL_speed
pop rax
pop rax

;print prompt and get miles from Long Beach to Fullerton
mov rax, 0
mov rdi, get_miles_LF
call printf
mov rax, 0
mov rdi, float_form
push qword 0
push qword 0
mov rsi, rsp
call scanf
movsd xmm12, qword[rsp]; xmm12 contains LF mile
pop rax
pop rax


;print prompt and get speed for from Long Beach to Fullerton
mov rax, 0
mov rdi, get_speed
call printf
mov rax, 0
mov rdi, float_form
push qword 0
push qword 0
mov rsi, rsp
call scanf
movsd xmm15, qword[rsp]; xmm15 contains LF speed
pop rax
pop rax


;initialize total variables
movsd xmm1, qword[total_distance]
movsd xmm2, qword[total_time]
movsd xmm3, qword[total_avg]



; Calculating Total Distance at xmm1
movsd xmm1, xmm10
addsd xmm1, xmm11
addsd xmm1, xmm12
; xmm1 now contains total distance

; Calculating Total Time at xmm2
movsd xmm2, xmm10
divsd xmm2, xmm13
movsd xmm3, xmm11
divsd xmm3, xmm14
addsd xmm2, xmm3
movsd xmm4, xmm12
divsd xmm4, xmm15
addsd xmm2, xmm4
; xmm2 now contains total time

; Calculating Average Speed
movsd xmm3, xmm1
divsd xmm3, xmm2 
; xmm3 now contains average speed

;move results into xmm10,11,12 for safty
movsd xmm10, xmm1 ;xmm10 contains distance
movsd xmm11, xmm2 ;xmm11 contains time
movsd xmm12, xmm3 ;xmm12 contains speed

; Print processing message
mov rax, 0
mov rdi, msg_procss
call printf

; Print total distance
mov rax, 1
mov rdi, msg_distance
movsd xmm0, xmm10
call printf
 
; Print total time
mov rax, 1
mov rdi, msg_time
movsd xmm0, xmm11
call printf

; Print average speed
mov rax, 1
mov rdi, msg_speed
movsd xmm0, xmm12
call printf

;move average speed into xmm0 for returning
movsd xmm0,xmm12

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

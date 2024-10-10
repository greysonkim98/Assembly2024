;Program name: "Non-deterministic Random Numbers". generate random number array, which has element between 1 and 2. Then sort
;the array.  
;;Copyright (C) 2024 Minjae Kim                                                                                             
;                                                                                                                           
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             
;<https://www.gnu.org/licenses/>.                                                                                           
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Minjae Kim
;  Author email: gorgeous9802@csu.fullerton.edu
;  Author CWID: 885206615
;  Author class: CPSC240-09
;  Assignment due date : 2024-Apr-15
;
;Program information
;  Program name: Non-deterministic Random Numbers
;  Programming languages: One module in C, two in X86, and one in bash.
;  Date program began: 2024-Apr-15
;  Date of last update: 2024-Apr-15
;  Files in this program: executive.asm, fill_random_array.asm, isnan.asm, main.c, normalize_array.asm, r.sh, show_array.asm
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  Gererate sorted normalized random number array
;
;This file:
;  File name: executive.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -l executive.lis -o executive.o executive.asm
;  or nasm -f elf64 -l executive.lis -o executive.o executive.asm
;  Assemble (debug): nasm -g dwarf -l executive.lis -o executive.o executive.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: double executive();
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
extern atoi
extern fill_random_array
extern normalize_array
extern show_array
extern sort

global executive

name_string_size equ 48
title_string_size equ 48
limit_size equ 100

segment .data

    get_name db "Please enter your name:   ", 0
    get_title db "Please enter your title (Mr,Ms,Sargent,Chief,Project Leader,etc): ",0
    msg_nice db "Nice to meet you %s %s.", 10,10, 0

    msg_error db "Invalid input. Please input the number 1~100",10, 0

    msg_intro1 db "This program will generate 64-bit IEEE float numbers.", 10 ,0
    msg_intro2 db "How many numbers do you want. Today’s limit is 100 per customer. ",0
    msg_intro3 db "Your numbers have been stored in an array.  Here is that array.", 10,10 ,0

    msg_normalize db 10,"The array will now be normalized to the range 1.0 to 2.0  Here is the normalized array" ,10,10,0
    msg_sort db 10,"The array will now be sorted",10,10,0

    msg_bye db "Good bye %s.  You are welcome any time.",10,10,0

    integer_form db "%d", 0


segment .bss

    align 64
    storedata resb 832
    name resb name_string_size
    title resb title_string_size

    limit resb limit_size
    random_number_array resq 100
 

segment .text
executive:

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

;Print the get_name promptname
mov rax, 0
mov rdi, get_name
call printf

;Input user names
mov rax, 0
mov rdi, name
mov rsi, name_string_size
mov rdx, [stdin]
call fgets

;Print the get_title prompt
mov rax, 0
mov rdi, get_title
call printf

;Input user title
mov rax, 0
mov rdi, title
mov rsi, title_string_size
mov rdx, [stdin]
call fgets

;Remove newline after title
mov rax, 0
mov rdi, title
call strlen
mov [title + rax-1], byte 0

;Remove newline after name
mov rax, 0
mov rdi, name
call strlen
mov [name + rax-1], byte 0

;Print nice to meet you followed by the name and title
mov rax, 0
mov rdi, msg_nice
mov rsi, title
mov rdx, name
call printf

;Print the introduction 1 prompt
mov rax, 0
mov rdi, msg_intro1
call printf

input_limit:
;Print the introduction 2 prompt
mov rax, 0
mov rdi, msg_intro2
call printf

;Obtain limit from user
mov rax, 0
mov rdi, limit
mov rsi, limit_size
mov rdx, [stdin]
call fgets

; Remove the newline character
mov rax, 0
mov rdi, limit
call strlen
mov byte[limit + rax -1], byte 0

; Conver limit from string to integer
mov rax, 0
mov rdi, limit
call atoi
mov r15, rax    ;r15 contains the number of elements to show

; Check the limit number is not greater than 100
mov r11, 100
mov r10, 1
cmp r15, r11
jg Error
cmp r15, r10
jl Error
jmp generate_array

Error:
mov rax, 0
mov rdi, msg_error
call printf
jmp input_limit

generate_array:
;Print the introduction 3 prompt
mov rax, 0
mov rdi, msg_intro3
call printf

; Generate random number in array "random_number_array"
mov rax, 0
mov rdi, random_number_array
mov rsi, r15
call fill_random_array

; Display array
mov rax, 0
mov rdi, random_number_array
mov rsi, r15
call show_array

; Prompt: normalizing
mov rax, 0
mov rdi, msg_normalize
call printf

; Nomalize the array
mov rax,0
mov rdi, random_number_array
mov rsi, r15
call normalize_array

; Display array
mov rax, 0
mov rdi, random_number_array
mov rsi, r15
call show_array

; Prompt: sorting 
mov rax, 0
mov rdi, msg_sort
call printf

; Sort array
mov rax, 0
mov rdi, random_number_array
mov rsi, r15
call sort

; Display array
mov rax, 0
mov rdi, random_number_array
mov rsi, r15
call show_array

; Print the prompt_goodbye
mov         rax, 0
mov         rdi, msg_bye
mov         rsi, title
call        printf

; Restore all the floating-point numbers
mov         rax, 7
mov         rdx, 0
xrstor      [storedata]

mov         rax, name

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
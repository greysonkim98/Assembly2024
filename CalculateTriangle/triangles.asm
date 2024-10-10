;****************************************************************************************************************************
;Program name: "Triangles".  This program calculate a triangle's legth of the last side after get user input: two sides'    *   
;legth and the angle between the sides. Also this program has input validaion for float input.                              *
;Copyright (C) 2024 Minjae Kim                                                                                              *
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
;  Assignment due date : 2024-Feb-24
;
;Program information
;  Program name: Triangles
;  Programming languages: One module in C, two in X86, and one in bash.
;  Date program began: 2024-Feb-15
;  Date of last update: 2024-Feb-23
;  Files in this program: driver.c, triangles.asm, isfloat.asm, r.sh.
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  Calculate triangle's length of last side with two sides' length and the angle between them.
;
;This file:
;  File name: triangles.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -l triangles.lis -o triangles.o triangles.asm
;  or nasm -f elf64 -l triangles.lis -o triangles.o triangles.asm
;  Assemble (debug): nasm -g dwarf -l triangles.lis -o triangles.o triangles.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: double triangles();
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
extern cos
extern isfloat
extern atof
extern sqrt
extern isfloat

null equ 0
true equ -1
false equ 0

global triangles

name_string_size equ 48
title_string_size equ 48


segment .data

    promt_time db 10, "The starting time on the system clock is %lu tics" ,10, 0
    promt_time_end db "The final time on the system clock is %lu tics" ,10,10,0 

    get_name db "Please enter your name:   ", 0
    get_title db "Please enter your title (Sargent, Chief, CEO, President, Teacher, etc):  ",0
    msg_goodmo db "Good morning %s %s. We take care of all your triangles.", 10,10, 0
    msg_goodd db "Have a good day %s %s.",10, 0

    get_first db "Please enter the length of the first side:  ",0
    get_second db "Please enter the length of the second side:  ",0
    get_angle db "Please enter the size of the angle in degrees:  ",0
    prompt_error db "Invalid input. Try again:" ,10,0

    msg_input db 10,"Thank you %s. You entered %1.6lf %1.6lf and %1.6lf.",10,0

    result db 10,"The length of the third side is %1.6lf",10,0

    msg_end db "This length will be sent to the driver program.",10,0

    float_form db "%lf", 0

    pi dq 3.14159265359
    one_eddy dq 180.0

segment .bss

    align 64
    storedata resb 832
    name resb name_string_size
    title resb title_string_size
    input_float resb 60

segment .text

triangles:

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

;Get tics
cpuid
rdtsc
shl rdx,32
add rdx,rax
mov r12,rdx

;Print tics
mov rax, 0
mov rdi, promt_time
mov rsi, r12
call printf 


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

;Print goodmorning you followed by the name and title
mov rax, 0
mov rdi, msg_goodmo
mov rsi, title
mov rdx, name
call printf

;*******************************************************first input********************************************************

first_input:

;Print prompt and get first side
mov rax, 0
mov rdi, get_first
call printf

;Get user first input
mov     rax, 0
mov     rdi, input_float
mov     rsi, 60
mov     rdx, [stdin]
call    fgets

;Remove the newline character
mov     rax, 0
mov     rdi, input_float
call    strlen
mov     [input_float + rax - 1], byte 0

;Check if input is a float
mov rax, 0
mov rdi, input_float
call isfloat
cmp rax, false 
je bad_input_1 ;jump bad_input1 if the input is not float

;Convert the input from string to float
mov rax, 0
mov rdi, input_float
call atof  
movsd xmm10, xmm0
;xmm10 contains float input

jmp second_input

;Error message and go back to first_input
bad_input_1:
mov rax,0
mov rdi, prompt_error
call printf
jmp first_input

;*******************************************************second input*******************************************************

second_input:
;Print prompt and get second side
mov rax, 0
mov rdi, get_second
call printf

;Get user second side input
mov     rax, 0
mov     rdi, input_float
mov     rsi, 60
mov     rdx, [stdin]
call    fgets

;Remove the newline character
mov     rax, 0
mov     rdi, input_float
call    strlen
mov     [input_float + rax - 1], byte 0

;Check if input is a float 
mov rax, 0
mov rdi, input_float
call isfloat
cmp rax, false
je bad_input_2 ;jump bad_input1 if the input is not float

;Convert the input from string to float
mov rax, 0
mov rdi, input_float
call atof  
movsd xmm11, xmm0
;xmm11 contains second side

jmp third_input

;Error message and go back to second input
bad_input_2:
mov rax,0
mov rdi, prompt_error
call printf
jmp second_input


;*******************************************************third input********************************************************

third_input:

;Print prompt and get angle 
mov rax, 0
mov rdi, get_angle
call printf

;Get user angle input
mov     rax, 0
mov     rdi, input_float
mov     rsi, 60
mov     rdx, [stdin]
call    fgets

;Remove the newline character
mov     rax, 0
mov     rdi, input_float
call    strlen
mov     [input_float + rax - 1], byte 0

;Check if input is a float
mov rax, 0
mov rdi, input_float
call isfloat
cmp rax, false 
je bad_input_3 ;jump bad_input_3 if the input is not float 

;Convert the input from string to float
mov rax, 0
mov rdi, input_float
call atof  
movsd xmm12, xmm0
;xmm12 contains angle

jmp calculation

;Error message and go back to third input
bad_input_3:
mov rax,0
mov rdi, prompt_error
call printf
jmp third_input ;just jump, no need to be equal

;********************************************************Calculation*******************************************************

calculation:

;Print the entered values
mov rax, 1
mov rdi, msg_input
mov rsi, name
movsd xmm0, xmm10
movsd xmm1, xmm11
movsd xmm2, xmm12
call printf

;Convert the float from degree to radian
mulsd   xmm12, qword[pi]
divsd   xmm12, qword[one_eddy]
;xmm12 contains radian angle

;Calculate cos(angle)
mov rax, 1
movsd xmm0, xmm12
call cos
movsd xmm12, xmm0
;xmm12 now contains cos(angle)

;Calculate a^2 + b^2 - 2ab * cos(angle)
movsd xmm1, xmm10   ; Load first side into xmm1
mulsd xmm1, xmm1    ; xmm1 = a^2

movsd xmm2, xmm11   ; Load second side into xmm2
mulsd xmm2, xmm2    ; xmm2 = b^2

movsd xmm3, xmm10   ; Load first side into xmm3
mulsd xmm3, xmm11   ; xmm3 = ab
mulsd xmm3, xmm12   ; xmm3 = ab * cos(angle)
addsd xmm3, xmm3    ;xmm3 = 2ab * cos(angle)

addsd xmm14, xmm1   ;xmm14 = a^2
addsd xmm14, xmm2  ; xmm14 = a^2 + b^2
subsd xmm14, xmm3  ; xmm14 = a^2 + b^2 - 2ab * cos(angle)

; Take the square root to get the length of the third side
mov rax,1
movsd xmm0, xmm14
call sqrt
movsd xmm14, xmm0 ; xmm14 contains the third side

; Print the result
mov rax, 1
mov rdi, result
movsd xmm0, xmm14
call printf

;Print end message
mov rax, 0
mov rdi, msg_end
call printf

;Get tics
cpuid
rdtsc
shl rdx,32
add rdx,rax
mov r12,rdx

;Print tics
mov rax, 0
mov rdi, promt_time_end
mov rsi, r12
call printf 

;Print goodmorning you followed by the name and title
mov rax, 0
mov rdi, msg_goodd
mov rsi, title
mov rdx, name
call printf 

movsd xmm0, xmm14

;'Save' the result onto the stack
push    qword 0
movsd   [rsp], xmm0

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

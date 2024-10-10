;****************************************************************************************************************************
;Program name: "Input Array". This a library function contained in a single file. This program receive the adress of        *
;the array, the size maximum of the array. The program will check the user input is float and stores into the array         *
;Copyright (C) 2024 Minjae Kim                                                                                              *
;                                                                                                                           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
;<https://www.gnu.org/licenses/>.                                                                                           *
;****************************************************************************************************************************

;Author information
;   Author name: Minjae Kim
;  Author email: gorgeous9802@csu.fullerton.edu
;   Author CWID: 885206615
;   Author class: CPSC240-09
;   Assignment due date : 2024-Mar-18
; 
;function information
;  Program name: input_array
;  Programming languages: X86 assmebly in Intel syntax
;  Date program began: 2024-Mar-10
;  Date of last update: 2024-Mar-15
;  Files in this program: input_array.asm
;  System requirements: an X86 platform with nasm installed o other compatible assembler.
;  Compiler used for testing: nasm version 2.15.05
;  Prototype:double compute_mean(double* ,long)
;
;Purpose
;  This function wil accept a array of float and calculate the mean which can be converted to a corresponding 64-bit 
;
;
;Translation information
;  compile command: nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
;

;========= Begin source code ====================================================================================
; input:
;       rdi: address of the array
;       rsi: max size of the array
;
; output: the numnber of elements in the array

global input_array
extern scanf
extern printf
extern isfloat
extern atof

segment .data
    format_string db "%s", 0
    prompt_tryagain db "That ain't no float, try again", 10, 0

segment .bss
    align 64
    storedata resb 832

segment .text
input_array:
    ; Back up GPRs
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    rcx
    push    rdx
    push    rsi
    push    rdi
    push    r8 
    push    r9 
    push    r10
    push    r11
    push    r12
    push    r13
    push    r14
    push    r15
    pushf

    ; Save all the floating-point numbers
    mov     rax, 7
    mov     rdx, 0
    xsave   [storedata]

    mov     r13, rdi    ; r13 contains the array
    mov     r14, rsi    ; r14 contains the max size
    mov     r15, 0      ; r15 is the index of the loop
    sub     rsp, 1024   ; Create a 1024 bits temporary space on the stack

begin:
    ; Obtain user float input
    mov     rax, 0
    mov     rdi, format_string
    mov     rsi, rsp
    call    scanf

    ; Check if the input is a Ctrl-D
    cdqe
    cmp     rax, -1
    je      exit

    ; Check if the input is a float
    mov     rax, 0
    mov     rdi, rsp
    call    isfloat
    cmp     rax, 0
    je      tryagain

    ; Convert the input into a float
    mov     rax, 0
    mov     rdi, rsp
    call    atof

    ; Copy the float into the array
    movsd   [r13 + r15 * 8], xmm0

    ; Increase r15, repeat the loop if r15 is less than the max size
    inc     r15
    cmp     r15, r14
    jl      begin

    ; Jump to exit otherwise
    jmp     exit      

tryagain:
    ; Prompt the user to try again and repeat the loop
    mov     rax, 0
    mov     rdi, prompt_tryagain
    call    printf
    jmp     begin

exit:
    ; Get rid of the 1024 bits temporary space on the stack
    add     rsp, 1024

    ; Restore all the floating-point numbers
    mov     rax, 7
    mov     rdx, 0
    xrstor  [storedata]

    mov     rax, r15

    ;Restore the original values to the GPRs
    popf          
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     r11
    pop     r10
    pop     r9 
    pop     r8 
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rbp

    ret
;End of the function average ====================================================================

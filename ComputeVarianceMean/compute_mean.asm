;****************************************************************************************************************************
;Program name: "Compute Mean". This a library function contained in a single file. This program receive the adress of       *
;the array, the size of the array, and generate mean.                                                                       *
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
;  Program name: compute_mean
;  Programming languages: X86 assmebly in Intel syntax
;  Date program began: 2024-Mar-10
;  Date of last update: 2024-Mar-15
;  Files in this program: compute_mean.asm
;  System requirements: an X86 platform with nasm installed o other compatible assembler.
;  Compiler used for testing: nasm version 2.15.05
;  Prototype:double compute_mean(double* ,long)
;
;Purpose
;  This function wil accept a array of float and calculate the mean which can be converted to a corresponding 64-bit 
;
;
;Translation information
;  compile command: nasm -f elf64 -l compute_mean.lis -o compute_mean.o compute_mean.asm
;

;========= Begin source code ====================================================================================

; Input: 
;   rdi = address of the first element of the array
;   rsi = size of the array
;
; output : the mean of the elements of the array 
;
global compute_mean
extern printf

segment .data
    float_form db 10,"total: %lf", 0
    float_form_1 db 10,"mean : %lf", 0
segment .bss
    align 64
    storedata resb 832
segment .text
compute_mean:

;Block that backs up almost all GPRs
;Back up the general purpose registers for the sole purpose of protecting the data of the caller.
push rbp                                          ;Backup rbp
mov  rbp,rsp                                      ;The base pointer now points to top of stack
push rdi                                          ;Backup rdi
push rsi                                          ;Backup rsi
push rdx                                          ;Backup rdx
push rcx                                          ;Backup rcx
push r8                                           ;Backup r8
push r9                                           ;Backup r9
push r10                                          ;Backup r10
push r11                                          ;Backup r11
push r12                                          ;Backup r12
push r13                                          ;Backup r13
push r14                                          ;Backup r14
push r15                                          ;Backup r15
push rbx                                          ;Backup rbx
pushf                                             ;Backup rflags

; Save all the floating-point numbers
mov     rax, 7
mov     rdx, 0
xsave   [storedata]
    
 
mov     r13, rdi        ; Pointer to array
mov     r14, rsi        ; The number of elements
mov     r15, 0          ; iterate counter = 0

sum_loop:
    movsd   xmm12, qword[r13 + r15 * 8]  ; Load array element into xmm0
    addsd   xmm11, xmm12                  ; Add to the sum in xmm11

    ; Increment loop counter
    inc r15
    ; Compare with the array size minus one
    cmp r15, r14
    jl sum_loop                          ; Continue looping if not at the end

    ; Calculate the mean
                          ; Pass the size of the array as the second argument
    cvtsi2sd xmm12, r14                  ; Convert the size to double      
    divsd xmm11, xmm12                   ; Divide the sum by the size to get the mean
 
;'Save' the result onto the stack
push    qword 0
movsd   [rsp], xmm11

; Restore all the floating-point numbers
mov     rax, 7
mov     rdx, 0
xrstor  [storedata]

; Retrieve the result from the stack
movsd   xmm0, [rsp]
pop     rax
    
popf                                    ;Restore rflags
pop rbx                                 ;Restore rbx
pop r15                                 ;Restore r15
pop r14                                 ;Restore r14
pop r13                                 ;Restore r13
pop r12                                 ;Restore r12
pop r11                                 ;Restore r11
pop r10                                 ;Restore r10
pop r9                                  ;Restore r9
pop r8                                  ;Restore r8
pop rcx                                 ;Restore rcx
pop rdx                                 ;Restore rdx
pop rsi                                 ;Restore rsi
pop rdi                                 ;Restore rdi
pop rbp                                 ;Restore rbp

ret
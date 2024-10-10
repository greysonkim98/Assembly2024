;Program name: "isnan". This a library function contained in a single file. This function return -1 is the received number
;is not less than the greatest normal number, otherwise return 0.
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
;  Program name: isnan
;  Programming languages: X86 assmebly in Intel syntax
;  Date program began: 2024-Apr-11
;  Date of last update: 2024-Apr-13
;  Files in this program: isnan.asm
;  System requirements: an X86 platform with nasm installed o other compatible assembler.
;  Compiler used for testing: nasm version 2.15.05
;  Prototype:int isnan(long)
;
;Translation information
;  compile command: nasm -f elf64 -l isnan.lis -o isnan.o isnan.asm
;
;
;========= Begin source code ====================================================================================
global isnan

null equ 0
true equ -1
false equ 0
max_normal equ 0x7fefffffffffffff

segment .data
;empty

segment .bss
;empty

segment .text
isnan:

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

check:

; Make a copy of the target into r13
mov r13, rdi
mov r12, max_normal

; If the target is less than maximum number of normal jump to return_false
cmp r13, r12
jl return_false

; If the target is not less than maximum number of normal return false
return_true:
mov rax, true
jmp restore_gpr_registers

; Return false
return_false:
mov rax, false
jmp restore_gpr_registers

restore_gpr_registers:
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

ret                                     ;Pop the integer stack and jump to the address represented by the popped value.


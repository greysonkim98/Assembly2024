;Program name: "show_array". This a library function contained in a single file. This program display elements in the array
;recevied
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
;  Program name: show_array
;  Programming languages: X86 assmebly in Intel syntax
;  Date program began: 2024-Apr-11
;  Date of last update: 2024-Apr-13
;  Files in this program: show_array.asm
;  System requirements: an X86 platform with nasm installed o other compatible assembler.
;  Compiler used for testing: nasm version 2.15.05
;  Prototype:double show_array(long* ,long)
;
;Translation information
;  compile command: nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm
;
;
;========= Begin source code ====================================================================================
global show_array
extern printf

segment .data
output_header db "IEEE754               Scientific Decimal", 10, 0
output_format db "0x%016lx    %-18.13g", 10, 0

segment .bss
    align 64
    storedata resb 832

segment .text

show_array:
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

mov         r13, 0     ; r13 keeps track of the index of the loop    
mov         r14, rdi     ; rdi contains the array
mov         r15, rsi     ; rsi contains the count of the array

; Print the header
mov         rax, 0
mov         rdi, output_header 
call        printf

display_loop:
; Check the index reach to the counts
cmp r13, r15
jge exit

; Print elements in hex and scienctific format
mov rax, 1
mov rdi, output_format
mov rsi, [r14 +r13 * 8]
movsd xmm0, [r14 + r13 * 8]
call printf

; Increase the index and go back to begin
inc r13
jmp display_loop

exit:
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
pop        rbx
pop         rbp

; Clean up
ret

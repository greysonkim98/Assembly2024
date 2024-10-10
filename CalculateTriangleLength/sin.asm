;Program name: sin
;
;This is a library function contain in a single file,
;This function received an angle in degree and return the sine of it
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
;   Assignment due date : 2024-May-12
; 
;function information
;  Program name: sin
;  Programming languages: X86 assmebly in Intel syntax
;  Date program began: 2024-May-10
;  Date of last update: 2024-May-11
;  Files in this program: sin.asm
;  System requirements: an X86 platform with nasm installed o other compatible assembler.
;  Compiler used for testing: nasm version 2.15.05
;  Prototype:double sin(double)
;
;Translation information
;  compile command: nasm -f elf64 -l sin.lis -o sin.o sin.asm
global sin

section .data
    pi_over_180 dq 0.017453292519943295    ; π/180 for converting degrees to radians
    three_fact  dq 6.0                     ; 3!
    five_fact   dq 120.0                   ; 5!
    seven_fact  dq 5040.0                  ; 7!

section .bss
 align 64
    storedata resb 832

section .text
sin:


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
   
    ; Input: xmm0 = angle in degrees
    ; Output: xmm0 = sin(angle)

    ; First, move the input angle from xmm0 to xmm15 for safekeeping
    movsd xmm15, xmm0

    ; Convert degrees to radians by multiplying with π/180
    movq xmm1, qword [pi_over_180]
    mulsd xmm15, xmm1                     ; xmm15 = angle (radians)

    ; Compute x^2 in xmm1
    movsd xmm1, xmm15
    mulsd xmm1, xmm15        ; xmm1 = x^2

    ; Compute x^3 in xmm2
    movsd xmm2, xmm1
    mulsd xmm2, xmm15        ; xmm2 = x^3

    ; Compute x^5 in xmm3
    movsd xmm3, xmm2
    mulsd xmm3, xmm1         ; xmm3 = x^5

    ; Compute x^7 in xmm4
    movsd xmm4, xmm3
    mulsd xmm4, xmm1         ; xmm4 = x^7

    ; Divide x^3 by 3! -> xmm2
    movq xmm5, qword [three_fact]
    divsd xmm2, xmm5

    ; Divide x^5 by 5! -> xmm3
    movq xmm5, qword [five_fact]
    divsd xmm3, xmm5

    ; Divide x^7 by 7! -> xmm4
    movq xmm5, qword [seven_fact]
    divsd xmm4, xmm5

    ; Compute the Taylor series:
    ; x - x^3/3! + x^5/5! - x^7/7!
    ; Start with x
    movsd xmm0, xmm15       ; xmm0 = x
    subsd xmm0, xmm2         ; xmm0 = x - x^3/3!
    addsd xmm0, xmm3         ; xmm0 = x - x^3/3! + x^5/5!
    subsd xmm0, xmm4         ; xmm0 = x - x^3/3! + x^5/5! - x^7/7!

     
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


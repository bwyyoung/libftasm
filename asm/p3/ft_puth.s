; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_puth.s                                          :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             ;
;   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

global _ft_puth

sys_exit        equ     1
sys_write       equ     0x2000004
stdout          equ     1

section .data
    outputBuffer times 4 db 0

section .text
    global _start

default rel

_ft_puth:
	mov  rcx, rdi               ; Number from 1st parameter rdi
	add  rcx, 0x30              ; Add 30 hex for ascii
	mov  [outputBuffer], rcx    ; Save number in buffer
	mov  rsi, outputBuffer      ; Store address of outputBuffer in rsi

	mov  rax, sys_write         ; sys_write
	mov  rdi, stdout            ; to STDOUT
	mov  rdx, 1                 ; length = one byte
	syscall
	ret
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_cat.s                                           :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ulefebvr <ulefebvr@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/03/24 13:46:06 by ulefebvr          #+#    #+#              ;
;    Updated: 2015/03/26 14:32:40 by ulefebvr         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

global	_ft_cat

extern _ft_strlen


section .data
	m_buff times 8 db 0
	m_buff_SZ equ $ - m_buff

section .text
_ft_cat:
stack_save:
	push	r9
main:
	cmp		rdi, 0x0
	jnge	Lret
	mov		r8, rdi
Lloop:
read:
	mov		rdi, r8
	mov		rsi, rsp
	mov		rdx, 8
	mov		rax, 0x2000003
	syscall
	jc		Lret
	cmp		rax, 0
	je		Lret
write:
	mov		rdi, 1
	mov		rdx, rax
	mov		rax, 0x2000004
	syscall
	jc		Lret
	jmp		Lloop

error_jump:
	mov	rdi, r9
	mov rax, 1

Lret: ;; Lret changing this variable name causes the scramble --> NEED TO SOLVE MYSTERY
	pop		r9
	ret
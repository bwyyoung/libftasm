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

section .data
	;m_buff times 8 db 0
	;m_buff_SZ equ $ - m_buff

section .text
_ft_cat:
	push	r8
	cmp		rdi, 0x0
	jnge	Lret

Lloop:
	mov		r9, rdi
	mov		rsi, rsp
	mov		rdx, 8
	mov		rax, 0x2000003
	syscall
	jc		Lret
	cmp		rax, 0
	je		Lret

	mov		rdi, 1
	mov		rdx, rax
	mov		rax, 0x2000004
	syscall
	jc		Lret
	mov		rdi, r9
	jmp		Lloop
	
Lret:
	pop		r8
	ret
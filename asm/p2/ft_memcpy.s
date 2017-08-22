; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_memcpy.s                                        :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             ;
;   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

global _ft_memcpy

extern _ft_puts
extern _ft_exit

; The locations of the source and destination operands are always specified by
; the DS:(R)SI and ES:(R)DI registers,
; which must be loaded correctly before the move string instruction is executed.
; http://www.felixcloutier.com/x86/MOVS:MOVSB:MOVSW:MOVSD:MOVSQ.html
; http://www.ques10.com/p/10819/what-is-rep-prefix-how-it-functions-for-string-i-1/

section .text

_ft_memcpy:

main:
	push	rdi		; destination pushed on stack (rdi), and pointer to first
					; element is preserved
	mov	rcx, rdx	; counter for rep (3rd param rdx)
	cld				; clear direction flag (rdi and rsi)
	rep	movsb		; rep uses rcx counter to repeat movsb
					; movsb increments rdi and rsi each time. handy function
					; ES: [DI] ← DS: [SI]
					; SI ← SI + I
					; DI ← DI + I
					; CX ← CX – 1

	pop	rax			; pop rdi into rax, getting back 1st ptr to rdi

	ret
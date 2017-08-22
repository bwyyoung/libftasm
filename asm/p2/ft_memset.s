; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_memset.s                                        :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             ;
;   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

global _ft_memset
	;First six arguments are in rdi, rsi, rdx, rcx, r8d, r9d
	;remaining arguments are on the stack.


_ft_memset:
	mov	r8, 0
	mov al, sil			;2nd argument is stored in 8 bit register sil(integer)
						;(rsi is the 64 bit register, and so does not have
						;our int, as it usually is reserved for strings)
						;move it to al for further use later.

loop_start:

set_mem:
	cmp rdx, 0				;check if 3rd argument (len) is zero
	jle loop_end			;if strlen <=0, return at loop_end
	mov	BYTE[rdi + r8], al	;write al into 1st argument(byte array) at current
							;pointer position
	inc r8					;increment byte array pointer position
	dec rdx					;decrement strlen
	jmp loop_start			;jump back to loop start

loop_end:
	mov rax, rdi
	ret

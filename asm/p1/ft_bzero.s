; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_bzero.s                                         :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             ;
;   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

global _ft_bzero

_ft_bzero:
			;First six arguments are in rdi, rsi, rdx, rcx, r8d, r9d
			;remaining arguments are on the stack.

loop_start:

set_zero:
	cmp rdi, 0
	jle loop_end
	cmp rsi, 0			;check if 2nd argument (strlen) is zero
	jle loop_end		;if strlen <=0, return at loop_end
	mov BYTE [rdi], 0	;write 0/null into 1st argument(byte array) at current
						;pointer position
	inc rdi				;increment byte array pointer position
	dec rsi				;decrement strlen
	jmp loop_start		;jump back to loop start

loop_end:
	ret
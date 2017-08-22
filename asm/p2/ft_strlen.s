; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_strlen.s                                        :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             ;
;   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

global _ft_strlen

section .text

_ft_strlen:
	push r10		;push a temp register to align stack
	push rbp; push_rbp (bottom of current stack frame) into stack & PRESERVE IT
	mov rbp, rsp ;move rsp (top of current frame) to bottom
	mov rax, 0

loop_start:
	cmp BYTE [rdi + rax], 0	;check if 2nd argument (strlen) is zero
	jle loop_end			;
	inc rax					;increment byte array pointer position
	jmp loop_start			;jump back to loop start

loop_end:
	mov rsp, rbp	;rbp is bottom of current stack frame (modified),
					;rsp is top of current stack frame (modified)
					;set TOP (rsp) to MODIFIED BOTTOM (rbp),
					;which we originally stored rsp;
	pop rbp			;rbp is pointing to bottom of current stack frame,
					;and we pop ORIGINAL RBP into rbp
	pop r10;
	ret
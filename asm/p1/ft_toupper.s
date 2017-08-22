; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_toupper.s                                       :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             ;
;   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

global _ft_toupper

_ft_toupper:
	call	_cmp_alpha_lower
	cmp		r8, 0
	je		exit_program
	sub		rdi, 'a'
	add		rdi, 'A'
	jmp		exit_program

_cmp_alpha_lower:
	cmp rdi, 'a'
	jl ret_false
	cmp rdi, 'z'
	jg ret_false
	jmp ret_true

ret_true:
	mov r8, 1
	ret

ret_false:
	mov r8, 0
	ret

exit_program:
	mov rax, rdi
	ret
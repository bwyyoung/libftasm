; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_tolower.s                                       :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             ;
;   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

global _ft_tolower

_ft_tolower:
	call	_cmp_alpha_upper
	cmp		r8, 0
	je		exit_program
	sub		rdi, 'A'
	add		rdi, 'a'
	jmp		exit_program

_cmp_alpha_upper:
	cmp rdi, 'A'
	jl ret_false
	cmp rdi, 'Z'
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
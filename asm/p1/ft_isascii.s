; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_isascii.s                                       :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             ;
;   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

global _ft_isascii

_ft_isascii:
	cmp rdi, 0
	jl ret_false
	cmp rdi, 127
	jg ret_false
	jmp ret_true

ret_true:
	mov rax, 1		;rax is return value, set it to true (1)
	ret
ret_false:
	mov rax, 0
	ret
; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_isalpha.s                                       :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             ;
;   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

global _ft_isalpha

_ft_isalpha:
	jmp _cmp_alpha_lower

_cmp_alpha_lower:
	cmp rdi, 'a'
	jl _cmp_alpha_upper
	cmp rdi, 'z'
	jg _cmp_alpha_upper
	jmp ret_true

_cmp_alpha_upper:
	cmp rdi, 'A'
	jl ret_false
	cmp rdi, 'Z'
	jg ret_false
	jmp ret_true

ret_true:
	mov rax, 1		;rax is return value, set it to true (1)
	ret
ret_false:
	mov rax, 0
	ret
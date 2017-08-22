; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_strcat.s                                        :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             ;
;   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

global _ft_strcat

_ft_strcat:
	mov		r8, 0
	mov		r9, 0
	mov		r10, 0
	call	_while_dest_end
	cmp		r10, 0
	jne		end_program
	call	_while_dest_src

_while_dest_src:
	cmp	BYTE[rsi + r9], 0
	je	str_end
	mov	r11, [rsi + r9]
	mov	[rdi + r8], r11
	inc	r8
	inc	r9
	jmp _while_dest_src

_while_dest_end:
	cmp	rdi, 0				;check bad pointer
	je	str_end_err			;jump, then pop stack
	cmp	BYTE[rdi + r8], 0	;compare current char at pointer array is null
	je	str_end				;jump, then pop stack
	inc	r8
	jmp	_while_dest_end

str_end:
	mov	rax, rdi
	ret

str_end_err:
	mov	rax, rdi
	mov r10, 1
	ret

end_program:
	ret;
; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_exit.s                                          :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             ;
;   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

global _ft_exit

_ft_exit:
	mov rax, 0x2000001		; System call number for exit = 1
	mov rdi, 0				; Exit success = 0
	syscall					; Invoke the kernel
; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_puts.s                                          :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             ;
;   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

global _ft_puts

extern _ft_exit

; int					ft_puts		(char *const str);
; ssize_t sys_write(unsigned int fd, const char * buf, size_t count)


section .data
	linefeed db 0x0a

section .text
_ft_puts:
	mov	r8, rdi				;store string in tmp location
	mov r9, 0

str_start:
	call	check_null
	cmp		r9, 0			;check if we reached str_end case
	jne		end_program		;quit program
	call	sys_write
	inc		r8
	jmp		str_start

check_null:
	cmp	r8, 0				;check bad pointer
	je	str_end_err			;jump, then pop stack
	cmp	BYTE[r8], 0			;compare current char at pointer array is null
	je	str_end				;jump, then pop stack
	ret

sys_write:
	mov	rax, 0x2000004		;system call number (sys_write)
	mov	rdi, 1				;file descriptor 1 - standard output
	mov	rdx, 1				;message length
	mov	rsi, r8				;message to write, second buf argument for sys_write
	syscall
	ret

str_end:
	mov r8, linefeed		;newline
	call sys_write
	mov rax, 1
	mov r9, 1
	ret;

str_end_err:
	mov r8, linefeed
	call sys_write
	mov rax, -1
	mov r9, 1
	ret;

end_program:
	ret;
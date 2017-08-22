; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_cat_2.s                                         :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             ;
;   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

global _ft_cat

extern _ft_strlen

;First six arguments are in rdi, rsi, rdx, rcx, r8d, r9d
;remaining arguments are on the stack.

section .data
	m_buff times 8 db 0
	m_buff_SZ equ $ - m_buff
	;TODO: if you comment these 2 vars, WHILE USING UMI METHOD,
	;your terminal will NOT be scrambled after executing
	;ft_cat(open(av[0], O_RDONLY));--> WHY?

section .text
_ft_cat:

stack_save:
	push r9
	;removed entry sequence to accommodate UMI Method
main:
	cmp rdi, 0x0
	jnge s_restore
	mov r8, rdi
read:
	mov rdi, r8
	mov		rsi, rsp		; --> UMI METHOD
	mov		rdx, 8			; --> UMI METHOD
	mov rax, 0x2000003		;set syscall to READ
	syscall					;call read function
	jc s_restore		;Jump If Carry to error (CF)
	cmp rax, 0
	je s_restore		;end of file, quit

write:
	mov	rdi, 1				;file descriptor 1 - standard output
	mov	rdx, rax			;message length
	mov	rax, 0x2000004		;system call number (sys_write)
	;rsi --> message to write, second buf argument for sys_write
	syscall
	jc s_restore			;Jump If Carry to error (CF)
	jmp read				;loop again as we have not finished

error_jump:
	mov	rdi, r8
	mov rax, 1

s_restore:
	pop r9
	;removed exit sequence to accommodate UMI Method
	ret



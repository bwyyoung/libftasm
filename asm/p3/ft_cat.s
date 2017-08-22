; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_cat.s                                           :+:      :+:    :+:   ;
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

	;UPDATE, found out that regular CAT also gets scrambled (/bin/cat cat):

;https://en.wikibooks.org/wiki/X86_Disassembly/Functions_and_Stack_Frames#Standard_Exit_Sequence
	;HACK --> AVOID ANY SCRAMBLE, however also fail to READ cat binary
	;basically, we need to do the entry and exit sequence, but we can only do
	; 1/2 of it (DO NOT push rbp) by saving and restoring rbp directly using rsp.
	;ft_cat(open(av[0], O_RDONLY)); is INDEPENDENT of causing the scramble
	;you get in your terminal --> YOUR rbp position IS, and it needs to be
	;updated with the modified rsp (TOP STACK) pointer.

section .text
_ft_cat:

stack_save:
	push r9
	push rbp		;push_rbp (bottom of current stack frame, BASE POINTER)
					;into stack & PRESERVE IT
	mov rbp, rsp	;move rsp (top of current frame) to bottom base pointer (rbp)

main:
	cmp rdi, 0x0
	jnge stack_restore
	mov r8, rdi
read:
	mov rdi, r8
	lea rsi, [rel m_buff]	;load buffer into register rsi(2nd param)
	mov rdx, m_buff_SZ		;load buffer length into rdx (3rd param)
	mov rax, 0x2000003		;set syscall to READ

	syscall					;call read function
	jc stack_restore		;Jump If Carry to error (CF)
	cmp rax, 0
	je stack_restore		;end of file, quit

write:
	mov	rdi, 1				;file descriptor 1 - standard output
	mov	rdx, rax			;message length
	mov	rax, 0x2000004		;system call number (sys_write)
	;rsi --> message to write, second buf argument for sys_write
	syscall
	jc stack_restore		;Jump If Carry to error (CF)
	jmp read				;loop again as we have not finished

error_jump:
	mov	rdi, r8
	mov rax, 1

stack_restore:
	mov rsp, rbp	;rbp is bottom of current stack frame (modified),
					;rsp is top of current stack frame (modified)
					;set MODIFIED BOTTOM (rbp) to TOP (rsp),
					;which we originally stored rsp;
	pop rbp			;rbp is pointing to bottom of current stack frame,
					;and we pop ORIGINAL RBP into
	pop r9
	ret



; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_strdup.s                                        :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: byoung-w <byoung-w@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2014/09/08 14:49:06 by byoung-w          #+#    #+#             ;
;   Updated: 2014/09/08 14:49:10 by byoung-w         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

global _ft_strdup

extern _ft_strlen
extern _ft_memcpy
extern _malloc
extern _ft_puts
extern _ft_exit
extern _ft_puth

;char			*ft_strdup(const char *str)
section .text

;--> https://forum.intra.42.fr/topics/1425/messages/last
;THE STACK POINTER %RSP MUST BE ALIGNED TO A 16-BYTE BOUNDARY BEFORE MAKING A CALL.
;Fine, but the process of making a call pushes the return address (8 bytes)
;on the stack, so when a function gets control, %rsp is not aligned.
;You have to make that extra space yourself, by pushing something
;or subtracting 8 from %rsp.
;http://cs.lmu.edu/~ray/notes/gasexamples/

_ft_strdup:

stack_save:
	push r15		;push a temp register to align stack
	push rbp		;push_rbp (bottom of current stack frame) into stack
					;& PRESERVE IT
	mov rbp, rsp	;move rsp (top of current frame) to bottom

main:
	cmp rdi, 0x0		;check if *str is null
	je null				;exit program if true

	call clone_string	;each time we do call, it adds to an existing stack
	jmp stack_restore

null:
	mov rax, rdi

stack_restore:
	mov rsp, rbp	;rbp is bottom of current stack frame (modified),
					;rsp is top of current stack frame (modified)
					;set TOP (rsp) to MODIFIED BOTTOM (rbp),
					;which we originally stored rsp;
	pop rbp			;rbp is pointing to bottom of current stack frame,
					;and we pop ORIGINAL RBP into rbp
	pop r15			;pop temp register
	ret

;r8 and r9 are used by malloc, so we use r12 and r13 to be safe
clone_string:
	mov r15, rsi
	mov r12, rdi		;save *str into a register first
	call _ft_strlen		;get length of rdi string, returned in rax

malloc:
	mov rcx, rax	;put strlen into rcx to be used by malloc
	mov r13, rax	;move the strlen into r13, which we will use later
	mov rdi, rax	;move the strlen into rdi, first param for malloc
	inc rdi			;increment rdi for malloc
	call _malloc	;call malloc, and return malloc *ptr into rax
	jc null

memcpy:
	mov rcx, r13
	mov rdi, rax	;move malloc mem into 1st param (the copy)
	mov rsi, r12	;move original string into src, 2nd param rsi
	mov rdx, r13	;move strlen into len, 3rd param, rdx
	call _ft_memcpy	;copy src into dest, dest returned as rax
	mov rsi, r15
	;rax is then given back to the user, because it is the COPY of the original
	;string

	ret

exiter:
	mov rdi, r12
	call _ft_puts
	call _ft_exit
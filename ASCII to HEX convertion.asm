global _start
_start:


section .text

%macro print 2

MOV rax,1
MOV rdi,1

MOV rsi,%1
MOV rdx,%2

syscall

%endmacro




;macro for accepting choices from user

%macro accept 2

MOV rax,0
MOV rdi,0

MOV rsi,%1
MOV rdx,%2
syscall
%endmacro



print msg,len

print msg1,len1

;accepting first half of number

accept num,2

call convert

MOV [no1],al


;accepting second half of the number

accept num,3

print msg,len

call convert

MOV [no2],al





;exit

MOV rax,60

MOV rdi,0

syscall




convert:

	MOV rsi,num

	MOV al,[rsi]

	cmp al,39H

	jbe l1

	sub al,7H

	l1:
		sub al,30H

		rol al,04H

		MOV bl,al

		inc rsi


	MOV al,[rsi]

	cmp al,39H

	jbe l2

	sub al,7H

	l2:
		sub al,30H

		rol al,04H


	add al,bl
ret








section .data


mtab db " "
ltab equ $-mtab


msg db " ",10
len equ $-msg


msg1 db " ENTER 4 DIGIT NUMBER: "
len1 equ $-msg1


section .bss

num resb 10

no1 resb 10

no2 resb 10








;============================================================================================


unix@unix-HP-dx2480-MT-KL969AV:~$ cd SEA03
unix@unix-HP-dx2480-MT-KL969AV:~/SEA03$ nasm -f elf64 -o convert.o convert.asmunix@unix-HP-dx2480-MT-KL969AV:~/SEA03$ ld -o convert convert.o
unix@unix-HP-dx2480-MT-KL969AV:~/SEA03$ ./convert
 
 ENTER 4 DIGIT NUMBER: FFFF
 
unix@unix-HP-dx2480-MT-KL969AV:~/SEA03$ 



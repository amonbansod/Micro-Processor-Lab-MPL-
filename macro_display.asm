global	_start

_start:


section	.text

;Macro for display

%macro print 2

	MOV rax,1
	MOV rdi,1
	MOV rsi,%1
	MOV rdx,%2
	syscall

%endmacro

print msg1,len1

print msg2,len2

;System call for exit

	MOV rax,60
	MOV rdi,0
	syscall


section .data

msg1 db "HELLO WORLD!!!                                                                 "
len1 equ $-msg1

global _start

_start:

;-------------------------------------------------------------------------------------------------

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

;-------------------------------------------------------------------------------------------------

print msg,len

	print msg1,len1

	;accepting  number

	accept num,3
	call convert
	MOV [no],al
	
print msg,len
print msg2,len2
	
	MOV rax,[no]
	MOV rcx,[no]
	dec rcx
	

l1:
	push rax
	dec rax
	cmp rax,1
	ja l1
	

l2:
	pop rbx
	mul rbx
	dec rcx
	jnz l2
	
	call displayproc
	
print msg,len
	
;exit

MOV rax,60
MOV rdi,0
syscall


;-------------------------------------------------------------------------------------------------

convert:
MOV rsi,num

	MOV al,[rsi]

	cmp al,39H

	jbe l13

	sub al,07H

	l13:
		sub al,30H

		rol al,04H

		MOV bl,al

		inc rsi


	MOV al,[rsi]

	cmp al,39H

	jbe l23

	sub al,7H

	l23:
		sub al,30H

	add al,bl



	ret

;-------------------------------------------------------------------------------------------------


displayproc:

	MOV rsi,disparr+15

    MOV rcx,16

    l8:
    	MOV rdx,0

        MOV rbx,10H

        div rbx

        cmp dl,09H
        jbe l18

        add dl,07H

	l18: 
		add dl,30h
        MOV [rsi],dl

        dec rsi

        dec rcx
        jnz l8

        print disparr,16

        print mtab,ltab
        ret
    
;-------------------------------------------------------------------------------------------------
        
        
section .data

msg db " ",10
len equ $-msg

mtab db " "
ltab equ $-mtab

msg1 db " ENTER  NUMBER TO CALCULATE ITS FACTORIAL:  "
len1 equ $-msg1

msg2 db" RESULT: "
len2 equ $-msg2

;-------------------------------------------------------------------------------------------------


section .bss

no resb 10

disparr resb 32

num resb 10



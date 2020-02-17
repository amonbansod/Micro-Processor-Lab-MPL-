global _start

_start:


;--------------------------------------------------------------------------


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




bmenu :  print msg,len

         print msg4,len4

         print msg,len

         print menu1,lmenu1

        accept choice1,2

        MOV al,byte[choice1]

        cmp al,31H
        je ch1

        cmp al,32H
        je ch2

		cmp al,33H
		je ch3




;--------------------------------------------------------------------------

ch1:

	print msg,len

	print msg1,len1

	;accepting first half of number

	accept num,3
	call convert
	MOV [no1],al

	print msg,len
	print msg2,len2

	;accepting second half of the number

	accept num,3
	call convert
	MOV [no2],al


print msg,len
print msg3,len3

	MOV ax,0000H

	l1:
		add ax,[no1]

		dec byte[no2]

		jnz l1


call displayproc


print msg,len
jmp bmenu

;--------------------------------------------------------------------------

ch2:
	print msg,len
	
	accept d,0

	print msg1,len1

	;accepting first half of number

	accept num,3
	call convert
	MOV [no1],al

	print msg,len
	print msg2,len2

	;accepting second half of the number

	accept num,3
	call convert
	MOV [no2],al
	
print msg,len
print msg3,len3

MOV ax,0000H
MOV [res],ax

MOV ax,[no1]
MOV bx,[no2]

rp:
	shr bx,1
	
	jnc l2
	
	add [res],ax
	
	l2:
		shl ax,1
		
		cmp ax,0000H
		
		je l3
		
	cmp bx,0000H
	
	jne rp
	
	l3:
		MOV ax,[res]
		
		call displayproc
	
	
	jmp bmenu

;--------------------------------------------------------------------------

ch3:
;exit
		MOV rax,60
		MOV rdi,0
		syscall


;--------------------------------------------------------------------------


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

;--------------------------------------------------------------------------


displayproc:

	MOV rsi,disparr+3

    MOV rcx,4

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

        print disparr,4

        print mtab,ltab
        ret

;--------------------------------------------------------------------------

section .data


mtab db " "
ltab equ $-mtab

msg db " ",10
len equ $-msg

msg1 db " ENTER FIRST NUMBER: "
len1 equ $-msg1

msg2 db " ENTER SECOND NUMBER: "
len2 equ $-msg2

msg3 db " PRODUCT OF THE TWO NUMBERS IS: "
len3 equ $-msg3


msg4 db "=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=",10
len4 equ $-msg4



menu1 db " 1] SUCCESSIVE ADDITION. ",10

	  db " 2] SHIFT & ADD. ",10

	  db " 3] EXIT",10

	  db "	",10

	  db "ENTER YOUR CHOICE: "

lmenu1 equ $-menu1




;--------------------------------------------------------------------------


section .bss

disparr resb 32

num resb 10

no1 resb 10

no2 resb 10

choice1 resb 02

res resw 02

d resb 10




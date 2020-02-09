
;Ignore the output section at the bottom as it can result in errors when compiled.


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

         print msg5,len5

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

	accept num,2
	call convert
	MOV [no1],al


	;accepting second half of the number

	accept num,3
	call convert
	MOV [no2],al


;--------------------------------------------------------------------------


	;HEX to BCD

	print msg,len

	print msg2,len2

	MOV rsi,array1

	MOV al,[no2]

	MOV ah,[no1]


	l2:
		MOV dx,0
	
		MOV bx,[rsi]

		div bx

		MOV [rem1],dx

		push rsi

		call displayproc1

		pop rsi

		MOV ax,[rem1]

		add rsi,2

		dec byte[cnt]

		jnz l2


	print msg,len

	jmp bmenu


;--------------------------------------------------------------------------


ch2:

	;BCD to HEX


	print msg,len

	print msg3,len3



	MOV rsi,array1

	l5:
		push rsi
	
		accept num,1

		pop rsi
	
		MOV al,byte[num]

		sub al,30H

		MOV bx,[rsi]

		mul bx

		add [result],ax

		add rsi,2

		dec byte [cnt2]

		jnz l5
		



	print msg,len

	print msg4,len4


	MOV ax,[result]
	call displayproc

	print msg,len


print msg,len
accept num,1
jmp bmenu


;--------------------------------------------------------------------------


ch3:	
;exit
		MOV rax,60
		MOV rdi,0
		syscall


;--------------------------------------------------------------------------


displayproc1:

	MOV rsi,disparr

    MOV rcx,1

    l3:
    	MOV rdx,0

        MOV rbx,10H

        div rbx

        cmp dl,09H
        jbe l11

        add dl,07H

	l11: 
		add dl,30h
        MOV [rsi],dl

        dec rsi

        dec rcx
        jnz l3

        print disparr,1

        print mtab,ltab
        ret

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

array1 dw 2710H,03E8H,0064H,000AH,0001H

cnt db 05H

cnt2 db 05H 

mtab db " "
ltab equ $-mtab

msg db " ",10
len equ $-msg

msg1 db " ENTER 4 DIGIT HEX NUMBER: "
len1 equ $-msg1

msg2 db " HEX to BCD: "
len2 equ $-msg2

msg3 db " ENTER 4 DIGIT BCD NUMBER: "
len3 equ $-msg3

msg4 db " BCD to HEX: "
len4 equ $-msg4

msg5 db "=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=",10
len5 equ $-msg5



menu1 db " 1] HEX TO BCD. ",10

	  db " 2] BCD TO HEX. ",10

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

rem1 resw 2

result resw 02

choice1 resb 02

















;==============================================================================================

;OUTPUT

unix@unix-HP-dx2480-MT-KL969AV:~$ cd SEA03
unix@unix-HP-dx2480-MT-KL969AV:~/SEA03$ nasm -f elf64 -o number_conversion.o number_conversion.asm
unix@unix-HP-dx2480-MT-KL969AV:~/SEA03$ ld -o number_conversion number_conversion.o
unix@unix-HP-dx2480-MT-KL969AV:~/SEA03$ ./number_conversion
 
=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 
 1] HEX TO BCD. 
 2] BCD TO HEX. 
 3] EXIT
	
ENTER YOUR CHOICE: 1
 
 ENTER 4 DIGIT HEX NUMBER: FFFF
 
 HEX to BCD: 6 5 5 3 5  
 
=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 
 1] HEX TO BCD. 
 2] BCD TO HEX. 
 3] EXIT
	
ENTER YOUR CHOICE: 2
 
 ENTER 4 DIGIT BCD NUMBER: 65535
 
 BCD to HEX: FFFF  
 
 
=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 
 1] HEX TO BCD. 
 2] BCD TO HEX. 
 3] EXIT
	
ENTER YOUR CHOICE: 3





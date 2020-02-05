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

section .data

array1 dw 2710H,03E8H,0064H,000AH,0001H

cnt db 05H

mtab db " "
ltab equ $-mtab

msg db " ",10
len equ $-msg

msg1 db " ENTER 4 DIGIT NUMBER: "
len1 equ $-msg1

msg2 db " HEX to BCD: "
len2 equ $-msg2




;--------------------------------------------------------------------------


section .bss

disparr resb 32

num resb 10

no1 resb 10

no2 resb 10

rem1 resw 2

















;==============================================================================================

unix@unix-HP-dx2480-MT-KL969AV:~$ cd SEA03
unix@unix-HP-dx2480-MT-KL969AV:~/SEA03$ nasm -f elf64 -o HEXtoBCD.o HEXtoBCD.asmunix@unix-HP-dx2480-MT-KL969AV:~/SEA03$ ld -o HEXtoBCD HEXtoBCD.o
unix@unix-HP-dx2480-MT-KL969AV:~/SEA03$ ./HEXtoBCD
 
 ENTER 4 DIGIT NUMBER: 2710
 
 HEX to BCD: 1 0 0 0 0  
unix@unix-HP-dx2480-MT-KL969AV:~/SEA03$ ./HEXtoBCD
 
 ENTER 4 DIGIT NUMBER: 03E8
 
 HEX to BCD: 0 1 0 0 0  
unix@unix-HP-dx2480-MT-KL969AV:~/SEA03$ ./HEXtoBCD
 
 ENTER 4 DIGIT NUMBER: 0064
 
 HEX to BCD: 0 0 1 0 0  
unix@unix-HP-dx2480-MT-KL969AV:~/SEA03$ ./HEXtoBCD
 
 ENTER 4 DIGIT NUMBER: 000A
 
 HEX to BCD: 0 0 0 1 0  
unix@unix-HP-dx2480-MT-KL969AV:~/SEA03$ ./HEXtoBCD
 
 ENTER 4 DIGIT NUMBER: 0001
 
 HEX to BCD: 0 0 0 0 1  
unix@unix-HP-dx2480-MT-KL969AV:~/SEA03$ ./HEXtoBCD
 
 ENTER 4 DIGIT NUMBER: 1234
 
 HEX to BCD: 0 4 6 6 0  


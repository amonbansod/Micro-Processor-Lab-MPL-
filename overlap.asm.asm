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

	cmp al,34H
	je ch4



ch1:    print msg,len

        print msg1, len1

        MOV rsi,Oarr

        l22:
        mov al,[rsi]
                push rsi

                call displayproc1

                pop rsi

                inc rsi

                dec byte[cnt3]

                jnz l22

        print msg,len

        jmp bmenu



ch2:
	print msg,len

	print msg2,len2
	
	MOV rsi,Oarr
	MOV rdi,Oarr

	add rsi,9
	add rdi,13

	l1:
		MOV al,[rsi]
		MOV [rdi],al

		dec rsi
		dec rdi
		dec byte[cnt1]
		jnz l1



	;to display Oarr

	MOV rsi,Oarr

	l2:
		MOV al,[rsi]
	
		push rsi

		call displayproc1

		pop rsi

		inc rsi

		dec byte[cnt2]

		jnz l2

		print msg,len

		jmp bmenu



ch3:
	print msg,len

	print msg3,len3

	MOV rsi,Oarr1
	MOV rdi,Oarr1

	add rsi,9
	add rdi,13

	MOV rcx,10

	std

	rep MOVsb

	;to display Oarr1

	MOV rsi,Oarr1

	l4:
		MOV al,[rsi]
	
		push rsi

		call displayproc1

		pop rsi

		inc rsi

		dec byte[cnt4]

		jnz l4

		print msg,len

		jmp bmenu





ch4:
	;exit
	MOV rax,60
	MOV rdi,0
	syscall



displayproc1:

                        MOV rsi,disparr+1

                        MOV rcx,2

                        l3:
                                MOV rdx,0

                                MOV rbx,10H

                                div rbx

                                cmp dl,09H
                                jbe l11

                                add dl,07H
l11: add dl,30h
                                MOV [rsi],dl

                                dec rsi

                                dec rcx
                                jnz l3

                        print disparr,2

                        print mtab,ltab
                        ret



section .data

Oarr db 01H,02H,03H,04H,05H,06H,07H,08H,09H,0AH,0BH,0CH,0DH,0EH,0FH

Oarr1 db 01H,02H,03H,04H,05H,06H,07H,08H,09H,0AH,0BH,0CH,0DH,0EH,0FH

cnt1 db 10

cnt2 db 15

cnt3 db 15

cnt4 db 15


menu1 db "1] DISPLAY SOURCE.",10

	  db "2] DISPLAY OVERLAP(without using string operation).",10

	  db "3] DISPLAY OVERLAP(using string operation).",10

	  db "4] EXIT.",10

	  db " ",10

	  db "ENTER YOUR CHOICE: "

lmenu1 equ $-menu1



mtab db " "
ltab equ $-mtab


msg db " ",10
len equ $-msg


msg1 db "SOURCE : "
len1 equ $-msg1


msg2 db "OVERLAP (without string opprn): ",10
len2 equ $-msg2


msg3 db "OVERLAP (using string opprn): ",10
len3 equ $-msg3


msg4 db "=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=",10
len4 equ $-msg4




section .bss

disparr resb 32
choice1 resb 02


;MENU DIVEN PROGRAM FOR BLOCK TRANSFER USING STRING OPERATION AND WITHOUT USING STRING OPERATION.
;========================================================================

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


;display source

ch1:    print msg,len

        print msg1, len1

        MOV rsi,Sarr

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
        ;copying source array to destination array(Darr)

        MOV rsi,Sarr

        MOV rdi,Darr

        l1:
                MOV al,[rsi]

                MOV [rdi],al

                inc rsi
                inc rdi

                dec byte[cnt1]
                jnz l1


        ;display destination array(Darr)

                print msg,len

                print msg2,len2

                MOV rsi,Darr

                l2:
                mov al,[rsi]
                        push rsi

                        call displayproc1

                        pop rsi

                        inc rsi

                        dec byte[cnt2]

                        jnz l2


                print msg,len

                jmp bmenu



ch3:
        ; copying source array to destination array using string operation

        MOV rsi,Sarr

        MOV rdi,Darr1

        cld     ;clear direction flag

        MOV rcx,10

        rep MOVsb       ;MOV string bit by bit




        ;to display destination array (Darr1)

                print msg,len

                print msg3,len3

                MOV rsi,Darr1

                l5:
                        MOV al,[rsi]

                        push rsi

                        call displayproc1

                        pop rsi

                        inc rsi

                        dec byte[cnt4]

                        jnz l5


                print msg,len

                jmp bmenu

ch4:    ;exit
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
;------------------------------------------------------------------------------

section .data

msg1 db "SOURCE : "
len1 equ $-msg1

mtab db " "
ltab equ $-mtab

msg db " ",10
len equ $-msg

msg2 db "DESTINATION(without using string oppration) : "
len2 equ $-msg2

msg3 db "DESTINTION(using string operation) : "
len3 equ $-msg3

msg4 db "=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=",10
len4 equ $-msg4

Sarr db 01H,02H,03H,04H,05H,06H,07H,08H,09H,10H

Darr db 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H

Darr1 db 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H

cnt1 db 10

cnt2 db 10

cnt3 db 10

cnt4 db 10


menu1 db " 1] DISPLAY SOURCE. ",10

      db " 2] DISPLAY NON-OVERLAP (without string operation).",10

      db " 3] DISPLAY NON-OVERLAP (with string operation).",10

      db " 4] EXIT.",10

      db " ENTER YOUR CHOICE: "

lmenu1 equ $-menu1
;---------------------------------------------------------------------------------------

section .bss
disparr resb 32

choice1 resb 02


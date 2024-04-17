; COMPILAR :
; 1- nasm fichero.asm -f obj
; 2- alink fichero.obj -oEXE

        segment Datos
Saludo  db '­Hola DOS!$'

        segment Pila stack
        resb 256
InicioPila:

        segment Codigo
..start:
        mov ax, Pila
        mov ss, ax
        mov sp, InicioPila

        mov ax, Datos
        mov ds, ax
        mov dx, Saludo
        mov ah, 9
        int 21h

        mov ah, 4ch
        int 21h


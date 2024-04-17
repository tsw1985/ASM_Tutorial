; COMPILAR :
; 1- nasm fichero.asm -f obj
; 2- alink fichero.obj -oEXE

;*********************************************
; ESTA RUTINA MUESTRA UN NUMERO EN AX en HEX 
; y lo pasa a DECIMAL
; PROCESO DE CREAR RUTINA FIBONACCI
;*********************************************

segment DATOS
	cadena db '00000$' ; acaba en $ para que la rutina pare donde encuentra el $

segment PILA stack
		resb 256
	InicioPila:
		;Aqui están los valores

segment CODIGO
	..start:

	MOV AX,1235 ; 80decimal
	MOV CX,10;  ; Dividimos 80/10
	XOR DX,DX   ; aqui irá el resto
	DIV CX       
	
	;suma 48 al valor del resto para obtener su digito en la tabla ascii.
	;Si da 5, sería 5+48 = 53 . Imprime un 5 ( 53 en ascii)
	ADD DL,'0'
	MOV AH,02H
	INT 21H
		
	;fin programa
	MOV AH,4Ch
	INT 21h
		

		

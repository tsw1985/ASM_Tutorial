; COMPILAR :
; 1- nasm fichero.asm -f obj
; 2- alink fichero.obj -oEXE

;*********************************************
; ESTA RUTINA MUESTRA UN NUMERO EN AX en HEX 
; y lo pasa a DECIMAL
;*********************************************

segment DATOS
	;cadena db '00000$' ; acaba en $ para que la rutina pare donde encuentra el $
	cadena db 4,'     $'; acaba en $ para que la rutina pare donde encuentra el $

segment PILA stack
		resb 256
	InicioPila:
		;Aqui están los valores

segment CODIGO
	..start:

	MOV AX,12347 ; 80decimal
	MOV BX,10;  ; Dividimos 80/10
	XOR DX,DX   ; aqui irá el resto
	DIV BX
	
	;imprimimos string usando la 9 de int 21. ds:dx
	
	MOV AX,DATOS 
	MOV DS,AX       ; METEMOS EN DS EL SEGMENTO DE LA VARAIBLE cadena
	ADD DX,'0'      ; sumamos el 0 . 48 en decimal que es el 0 en ascii.
	MOV [cadena],DX ; GUARDAMOS EL VALOR DEL RESTO QUE ESTÁ EN PILA EN LA VARAIBLE
	
	LEA DX,[cadena] ; METEMOS EN DX EL OFFSET DE cadena
	MOV AH,09h      ; INVOCAMOS AL SERVICIO DE IMPRIMIR CADENA EN PANTALLA
	INT 21h         ; EJECUTAMOS RUTINA DE IMPRIMIR
	
	;fin programa
	MOV AH,4Ch
	INT 21h
	

;************************************************************************	
;suma 48 al valor del resto para obtener su digito en la tabla ascii.
;Si da 5, sería 5+48 = 53 . Imprime un 5 ( 53 en ascii)
;ADD DL,'0'
;MOV AH,02H
;INT 21H
; cadenacall.asm
; COMPILAR :
; 1- nasm fichero.asm -f obj
; 2- alink fichero.obj -oEXE
;********************************************************
; ESTA RUTINA DIVIDE UN NUMERO, GUARDA SU RESTO
; Y LO GUARDA EN LA VARIABLE cadena, EN PRIMERA POSICION
;********************************************************

segment DATOS
	cadena DB '                           $'    ; acaba en $ para que la rutina pare donde encuentra el $
	indice DB 0

segment PILA stack
		resb 256
	InicioPila:
		;Aqui están los valores

segment CODIGO
	..start:

MOV AX,12345 ; 

GET_NUMBER:
	XOR CX,CX  ; ponemos CX a 0 para ir guardando cuantos elementos van a la PILA
	MOV BX,10;   ; Dividimos 80/10
	XOR DX,DX    ; aqui irá el resto
	DIV BX       ; dividimos 12345 / BX (5)
	PUSH DX      ; guardamos en la pila los numeros
	INC CX       ; incrementamos CX para ir guardando cuantos numeros van
	
	MOV [indice],CX ; guardo en indice las iteraciones

	; guardamos los restos en la variable cadena para luego imprimirla
	MOV AX,DATOS 
	MOV DS,AX       ; METEMOS EN DS EL SEGMENTO DE LA VARAIBLE cadena
	ADD DX,'0'      ; sumamos el 0 . 48 en decimal que es el 0 en ascii.
	
	;POP AX
	;POP BX
	
	MOV BX,[indice]
	MOV [cadena + BX],DX ; GUARDAMOS EL VALOR DEL RESTO QUE ESTÁ EN PILA EN LA VARAIBLE
	
	CALL PRINT_NUMBER
	
	
	
	;fin programa
	MOV AH,4Ch
	INT 21h
	
	
PRINT_NUMBER:
	
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	
	MOV AX,DATOS 
	MOV DS,AX       ; METEMOS EN DS EL SEGMENTO DE LA VARAIBLE cadena
	LEA DX,[cadena] ; METEMOS EN DX EL OFFSET DE cadena
	MOV AH,09h      ; INVOCAMOS AL SERVICIO DE IMPRIMIR CADENA EN PANTALLA
	INT 21h         ; EJECUTAMOS RUTINA DE IMPRIMIR

	POP DX
	POP CX
	POP BX
	POP AX

	RET
	

	
	;MOV AX,1234 ; 
	;MOV BX,10;  ; Dividimos 80/10
	;XOR DX,DX   ; aqui irá el resto
	;DIV BX

	
	;MOV AX,123 ; 
	;MOV BX,10;  ; Dividimos 80/10
	;XOR DX,DX   ; aqui irá el resto
	;DIV BX
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
	indice DW 0
	resto  DW 0
	nextCociente DW 12345 ; (int) usamos un DWORD para guardar valores

segment PILA stack
		resb 256
	InicioPila:
		;Aqui están los valores

segment CODIGO

..start:

GET_NUMBER:
	XOR AX,AX
	MOV AX,DATOS
	MOV DS,AX
	MOV AX,[nextCociente] ;12345 ;
	XOR CX,CX             ; ponemos CX a 0 para ir guardando cuantos elementos van a la PILA
	MOV CX,[indice]

	; DIVISION
		MOV BX,10;   		; Dividimos 12345/10
		XOR DX,DX           ; aqui irá el resto
		DIV BX              ; dividimos 12345 / BX (5)
		MOV [nextCociente], AX; segun dividimos metemos en nextCociente el cociente
		MOV [resto],DX      ; guardamos en resto el valor de resto 
		INC CX              ; incrementamos CX para ir guardando cuantos numeros van
		MOV [indice],CX     ; guardo en indice las iteraciones
		
		

	; FIN DIVISION
	
	; GUARDAR DIGITO ASCII EN variable CADENA
		XOR AX,AX       		; ponemos AX a cero
		MOV AX,DATOS    		; guardamos los restos en la variable cadena para luego imprimirla
		MOV DS,AX       		; METEMOS EN DS EL SEGMENTO DE LA VARAIBLE cadena
		ADD DX,'0'      		; sumamos el 0 . 48 en decimal que es el 0 en ascii.
		MOV BX,[indice] 		; ponemos en BX el valor de INDICE 0,1,2,3... para ir avanzando en cadena
		MOV [cadena + BX],DX 	; GUARDAMOS EL VALOR 
	; FIN GUARDAR DIGITO ASCII EN variable CADENA
	
	; PONEMOS DE NUEVO AX con el valor del cociente actual
	MOV AL,[resto] 					; ¿ Quiza no haga falta ?
	CMP AL,0
	JE PRINT_NUMBER
	JNE GET_NUMBER

	
FIN:	
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
	
	CALL FIN

	RET
; COMPILAR :
; 1- nasm fichero.asm -f obj
; 2- alink fichero.obj -oEXE
;***********************************************************************************
; ESTA RUTINA IMPRIME UN NUMERO EN PANTALLA . PARA ELLOS NECESITAMOS
; IR DIVIDIENDO EL NUMERO ENTRE 10 , OBTENER EL RESTO QUE SERÁ EL DÍGITO
; E IR GUARDANDOLO EN LA PILA PARA LUEGO OBTENERLO.
; EN ESTE EJEMPLO EL NUMERO EN CUESTION ES nextCociente , QUE PODRÍA SER ASIGNADO
; DESDE OTRA RUTINA Y LUEGO LLAMAR A ESTO PARA IMPRIMIRLO.
;***********************************************************************************

segment DATOS
	cadena RESB 50                            ; acaba en $ para que la rutina pare donde encuentra el $
	contador DW 0
	resto  DW 0
	contadorParaCadena DW 0
	nextCociente DW 11450 ; (int) usamos un DWORD para guardar valores

segment PILA stack
		resb 256
	InicioPila:
		;Aqui están los valores

segment CODIGO

..start:

MOV CX,0 ; inicia CX a 0
GET_NUMBER:
	XOR AX,AX
	MOV AX,DATOS
	MOV DS,AX
	MOV AX,[nextCociente] ;12345 ;
	

	; DIVISION
	MOV BX,10;   		; Dividimos 12345/10
	XOR DX,DX           ; aqui irá el resto
	DIV BX              ; dividimos 12345 / BX (10)
	MOV [nextCociente], AX; segun dividimos metemos en nextCociente el cociente
	
	PUSH DX             ; guardamos resto en PILA que está en DX
	MOV [resto],DX      ; y tambien lo guardamos en la variable RESTO
	
	MOV CX,[contador]
	INC CX              ; incrementamos CX para ir guardando cuantos numeros van
	MOV [contador],CX     ; guardo en contador las iteraciones
	
	; PONEMOS DE NUEVO AX con el valor del cociente actual
	MOV AX,[nextCociente] 					
	CMP AX,0 			; ¿ ya el resto es 0 ?
	
	
	JE PROCESO_IMPRIMIR_NUMERO; ¿ si ? pues vamos a sacar los numeros
	JNE GET_NUMBER      ; ¿ no ? sigue dividiendo

PROCESO_IMPRIMIR_NUMERO:

	XOR CX,CX
	MOV CX,[contador] ; ponemos el contador de CX con el total de iteraciones de division
				      ; ya que la instruccion LOOP necesita que CX tenga el numero de iteraciones

SACA_RESTO: ; GUARDAR DIGITO ASCII EN variable CADENA
	
	XOR AX,AX       		; ponemos AX a cero
	MOV AX,DATOS    		; guardamos los restos en la variable cadena para luego imprimirla
	
	POP DX
	
	MOV DS,AX       		; METEMOS EN DS EL SEGMENTO DE LA VARAIBLE cadena
	ADD DX,'0'      		; sumamos el 0 . 48 en decimal que es el 0 en ascii.
	MOV BX,[contadorParaCadena] ; ponemos en BX el valor de contador 0,1,2,3... para ir avanzando en cadena
	MOV [cadena + BX],DX 	; GUARDAMOS EL VALOR 
	
	INC BX                  ;incrementamos BX para que en la siguiente vuelta sea +1
	MOV [contadorParaCadena],BX ; guardamos en el contador su numero valor incrementado +1
LOOP SACA_RESTO

	;añadimos el $ al final de la CADENA
	INC BX                  ; le sumo 1 más para añadir el caracter $ que indica fin de cadena 
	MOV AL,'$'              ; uso AL para guardar el caracter $
	MOV [cadena + BX],AL 	; GUARDAMOS EL VALOR $ en el final de la cadena.

CALL PRINT_NUMBER           ; imprimimos ya el numero
CALL FIN				    ; terminamos la ejecucion del programa
	

	
	
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
	
	;CALL FIN

	RET
	
FIN:                ;fin programa
	MOV AH,4Ch
	INT 21h	
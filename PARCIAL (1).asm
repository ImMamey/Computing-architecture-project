	LIST P=16F84

;Victor Vásquez = 24464628
;Francisco Proce= 20914366
      ;segundos a utilizar = 66 segundos
;==== Declaracion de variables

OP			EQU		01H
TMR0		EQU		01H
CONTEOINT		EQU		0BH
PORTA		EQU		05H ;puertoa
STATUS		EQU		03H
CONTEO			EQU		10H
CONTADORA		EQU		20H
CONTADORB		EQU		21H
PA			EQU		05H

;=== Inicio del programa===
		ORG 0
		GOTO 	INICIO ;salto al inicio del programa

;===Inicialiazacion de varaibles y de puertos del pic==

INICIO 	ORG		10           ;inicio
		CLRF	PORTA
		BSF 	STATUS,5	; se declara el banco de memoria  en 
		BCF		PORTA,0	    ;se declara el puerto 0 como de salida
		BCF		PORTA,1	    ;se declara el puerto 1 como de salida
		BCF		PORTA,2     ;se declara el puerto 2 como de salida
		BSF		PORTA,3	    ;se declara el puerto 3 como de entrada 
	
		MOVWF	B'00000111' ;se guarda en w el valor "00000111"
		MOVWF	OP	        ;se guarda el divisor a 256
		BCF		STATUS,5    ;se camba el banco de memoria, al banco 0

		MOVLW	B'10100000' ; moviendo el valor de 10100000 a W
		MOVWF	CONTEOINT      ; se habilitan las interrupciones
		
		MOVLW	D'217'      ; se guarda el valor "217" en w
		MOVWF	TMR0	    ;se precarga el timer en "217"
		MOVLW	D'100'      ; se guarda el valor de 100 en 2
		MOVWF	CONTEO	        ; cargando la variable de conteo como 100
;===Interaccion con el boton Start	
BUCLE                       ;bucle, cambia si el boton "START" ah sido presionado
			
	BTFSC	PORTA,3        ;condicionador, si es igual a 1 se salta la siguiente linea, si es 0 vuelve a entrar en el bucl
	GOTO 	BUCLE          ;si es 1 se salta esta linea
	
	GOTO	ENCIENDE       ;si es 1 entra a esta linea

;==instruccion bloque de encendido
ENCIENDE	
	
	MOVLW	B'00000011'   ;se guarda el valor "00000011" eb w
	MOVWF	PORTA         ;se guarda el valor de la linea anterior al puerto A
	GOTO	N1            ; se llama a un bloque de memoria indefinido

;===bloque de memoria indefinido, las llamadas no hacen nada, es una pausa que dura un ciclo de maquiina
N1	NOP           
	NOP
	GOTO	N1 ;salto a la etiqueta N1
	
	ORG		4            ;vector de la interupcion
	GOTO	INTER        ;salta a la etiqueta de llamada de la interrupcion

;===Llamadas a las interrupciones
INTER	ORG 50
		DECFSZ CONTEO,1	;Decremento la vaiable de conteo, al llegar a 0 salta linea
		GOTO	N3      ;mientras el valor de la linea anterior no sea cero, entra en esta linea y salta a N3 para la etiqueta de interrupcion
		GOTO	SEG     ;Si el valor de 2 lineas arriva es 0, entra en esta linea y 

;===Llamada a Paua de interrupcion
;esta etiqueta genera una interrupciohn de 33~ segundos dos veces
N3		CALL	RETARDO ;primera interrupcion
		CALL	RETARDO ;segunda interrupcion 
		MOVLW	d'217'  ;se guarda 217 en w (s)
		MOVWF	TMR0    ;se precarga el timer con el valor de w (217)
		BCF		CONTEOINT,2; apagado de la bandera de interrupcion
		RETFIE          ; salida de la interrupcion

SEG
		BTFSC	PORTA,2 ;Si el bit del puerto A es 2 se salta una linea
		GOTO	OFF     ;Si la linea anterior es falsa, entra en la etiqueta Off, la cual no hace nada
		BSF		PORTA,2 ;
		BCF		PORTA,1 ;
		GOTO	N2      ;se salta a la etiqueta 2
OFF		NOP             ; no se hace nada por un ciclo de procesamiento
N2		MOVLW	D'100' ;se guarda el valor "100" en w
		MOVWF	CONTEO    ; se guarda la variable de conteo como un 100
		GOTO	N3     ; se salta a la etiqueta de retardo
	
;===Llamada a las interrupciones, (tiempo exacto)
RETARDO	
		MOVLW	D'250' ;se guarda "250" en w (25 segundos)
		MOVWF	CONTADORA ;se asigna el valor previo (w) a conta1
BUCLE2	MOVLW	D'250' ;se guarda "250" en w (25 segundos)
		MOVWF	CONTADORB ;se asigna el valor previo (2) a conta2
BUCLE1	NOP              ; no realiza ninguna operacion, pero se gasta un ciclo de maquina
		DECFSZ	CONTADORB,F ;decrementa el contador B
		GOTO	BUCLE1      ;se entra en el bucle 1
		DECFSZ	CONTADORA,F ;decrenebta ek contador F
		GOTO	BUCLE2      ;entrada a la etiqueta "bucle 2"
		RETURN

		END

		
	
					
	

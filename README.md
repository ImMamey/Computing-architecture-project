# PC architecture project
 
UNIVERSIDAD CATOLICA ANDRES BELLO
FACULTAD DE INGENIERIA
ESCUELA DE INGENIERIA INFORMATICA
CATEDRA DE ARQUITECTURA DEL COMPUTADOR
ACTIVIDAD TEORICO-PRACTICA
PROF BIAGIO CANTE

Dado el siguiente esquema, se quiere diseñar un circuito que permita la
activación de un motor trifásico, en lo que se denomina un arranque estrella triangulo,
se supone que a la salida de los puertos estarán relays que manejan la carga del
motor, hoy se simularan con diodos LED, si tendrá un pulsador que será el de inicio y
botón de stop que será el pulsador de reset. Se tendrán tres salidas, la cuales serán
PA0 >>> Principal
PA1 >>> Estrella
PA2 >>> Triangulo
Las entradas serán
PA3 >>> Start

Cuando se presione el botón de start, se colocara en 1 lógico el puerto PA0 y
también el puerto PA1, luego de pasado un tiempo T igual a XX seg (XX segundos
serán los dos últimos números de su cedula, si sus dos últimos números de cedula son
menores que 10, utilizara 10 seg) se colocara en 0 el puerto PA1, y se colocara en 1 el
puerto PA2, dejando a PA0 en 1, quedando así solo hasta que se presione el botón de
reset, que servirá como botón de stop.
Nota : Recuerde que el tiempo empezara a transcurrir después que de pulse el
botón de start, antes todo deberá de estar en 0 (las tres salidas).
Instrucciones

Deberá de entregar el archivo .ASM, dentro del programa en comentarios
deberán de estar los nombres de los integrantes del grupo, además que se debe
comentar cada línea del código. También deberá de entregar el archivo .HEX y el
.DSN de proteus en la versión 7, dentro de esquema deberán de estar también los
nombres de los participantes del grupo.
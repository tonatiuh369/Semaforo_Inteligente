'BASIC converted from flowchart: 
'D:\Docms and Sttngs\Usuario\Escritorio\Escritorios C y E\Escritorio\Semestre 2010-1\Máquinas Digitales\PICAXE - semáforo inteligente\Semáforo Inteligente (diagrama de flujo)(v3).cad
'Converted on 26/12/2009 at 02:16:35
'SEMAFORO INTELIGENTE

symbol Av = 0	'Av es la luz verde de A (output 0)
symbol Aa = 1	'Aa es la luz amarilla de A (output 1)
symbol Ar = 2	'Ar es la luz roja de A (output 2)
symbol Bv = 3	'Bv es la luz verde de B (output 3)
symbol Ba = 4	'Ba es la luz amarilla de B (output 4)
symbol Br = 5	'Br es la luz roja de B (output 5)
symbol autos_en_A = b0	'Para guardar la cantidad contada de autos en A
symbol autos_en_B = b1	'Para guardar la cantidad contada de autos en B
symbol TIEMPO_L = w5 'Tiempo Largo: es la duraciOn de las luces verdes y rojas de A o B
symbol TIEMPO_C = w6 'Tiempo Corto: es la duraciOn de las luces amarillas de A o B
symbol i = b8

Main:
		
		let TIEMPO_L=5000  'Valor de prueba. En realidad debe valer aprox. 50 segundos
		let TIEMPO_C=1500  'Valor de prueba. En realidad debe valer aprox. 4 segundos	

Salto_1:	let i=1
		let pins = %00100001	'Enciende Av y Br, los demAs apagados
		gosub CONTADOR
		let i= 2

Salto_2:	if autos_en_A<autos_en_B then Salto_3
		let pins = %00100001	'Enciende Av y Br, los demAs apagados
		gosub CONTADOR
		if i= 3 then Salto_3
		let i=i+1
		goto Salto_2

Salto_3:	let pins = %00100010	'Enciende Aa y Br, los demAs apagados
		gosub AMARILLO_A_VERDE
		let pins = %00001100	'Enciende Ar y Bv, los demAs apagados
		let i= 1

Salto_4:	if autos_en_B<autos_en_A then Salto_5
		let pins = %00001100	'Enciende Ar y Bv, los demAs apagados
		gosub CONTADOR
		if i= 3 then Salto_5
		let i=i+1
		goto Salto_4

Salto_5:	let pins = %00010100	'Enciende Ar y Ba, los demAs apagados
		gosub AMARILLO_A_VERDE
		goto Salto_1

CONTADOR:	
		 count 0,TIEMPO_L,w0	'Cuenta los pulsos en el pin 0 (input) que estA conectado al switch A
		 count 1,TIEMPO_L,w1	'Cuenta los pulsos en el pin 1 (input) que estA conectado al switch B
		 let autos_en_A=w0
		 let autos_en_B=w1
		pause TIEMPO_L
		return

AMARILLO_A_VERDE:	
		pause TIEMPO_C
		return
# POC_Red
POC_Red es un modulo que permite gestionar redes y nodos y asi transmitir mensajes entre ellos.

## Casos de uso

- Crear una partida de 2 jugadores
	- Cliente Ale
	- Cliente Juan
	- Orquestador

	- Orquestador setup crea una red que termina creando un servidor (godot)
	- Orquestador crea un nodo en la red que lo va a representar, es decir tiene peer_id 1 que para godot es el servidor y tamb le pone modo de comunicacion por referencia
	- Cliente Juan configura una partida y le da crear
		- en el cliente se crea un cliente (godot) y se conecta al servidor por IP local (automatico)
		- llama a la funcion remota execute de la red y pasa un comando (accion + mensaje), el peer_id destina es 1 (que va a matchear con el nodo del orquestador)
		- la funcion execute hace:
			- autentica la llamada, es decir obtiene le peer_id que hizo la llamada y lo matchea con un nodo registrado por peer_id
				- si no encuentra ninguno queda como nodo nulo
			- crea la operacion de envio
				- nodo origen es el nodo que se autentico o nodo_anonimo si no autentico ninguno
				- nodo destino es el nodo del orquestador pq peer_id es 1
				- mensaje es el mensaje del comando
				- genera la operacion de envio
				- guarda la operacion de envio
				- envia el mensaje por referencia pq el orquestador (peer_id 1) se configuro con ese modo de comunicacion
			- se ejecuta la funcion execute del orquesator con el comando como argumento
				- esta funcion tiene un mapeo del nombre del comando (o caso de uso) con una funcion interna del orquestador
				- se termina ejecutando la funcion interna "crear partida" con el mensaje como argumento y el nodo origen como otro argumento
				- el orquestador registra al cliente Juan como nodo en la red con el peer_id correspondiente (lo toma del argumento nodo origen) y comunicacion rcp
				- llama a sincronizar jugadores
		- El orquestador sincroniza los jugadores (hasta ahora solo Juan) usando la red
	- Cliente Ale, da a conectarse a partida y pone la IP de Juan
		- en el cliente se crea un cliente (godot) y se conecta a la IP de Juan (que vino de la UI)
		- El flow de registro de este nodo es como en el caso de Juan
		- llama a la funcion remota execute de la red y pasa un comando (accion + mensaje), el peer_id destina es 1 (que va a matchear con el nodo del orquestador)
		- la funcion execute hace:
			- autentica la llamada, es decir obtiene le peer_id que hizo la llamada y lo matchea con un nodo registrado por peer_id
				- si no encuentra ninguno queda como nodo nulo
			- crea la operacion de envio
				- nodo origen es el nodo que se autentico o nodo_anonimo si no autentico ninguno
				- nodo destino es el nodo del orquestador pq peer_id es 1
				- mensaje es el mensaje del comando
				- genera la operacion de envio
				- guarda la operacion de envio
				- envia el mensaje por referencia pq el orquestador (peer_id 1) se configuro con ese modo de comunicacion
			- se ejecuta la funcion execute del orquesator con el comando como argumento
				- esta funcion tiene un mapeo del nombre del comando (o caso de uso) con una funcion interna del orquestador
				- se termina ejecutando la funcion interna "unirse a partida" con el mensaje como argumento y el nodo origen como otro argumento
				- el orquestador registra al cliente Ale como nodo en la red con el peer_id corresponidente (lo toma del argumento nodo origen) y comunicacion rcp
				- llama a sincronizar jugadores
		- El orquestador sincorniza los jugadores (Juan y Ale) usando la red


## Conceptos

- Red
	- La red es el espacio o entidad a la que se pueden conectar los nodos, y por la cual se pueden transmitir mensajes.
	- Info
		- id
		- nodos registrados
	- Funciones
		- registrar nodo
		- desregistrar nodo
		- distribuir mensaje
			- implica generar un remito por cada comunicacion 1a1
			- implica guardar el mensaje y el remito
		- autenticar nodo
		- aniadir etiqueta a los nodos
		- eliminar etiqueta a los nodos
		- filtrar nodos por etiquetas
		- filtrar mensajes por estado
		- obtener estado de los nodos
- Nodo
	- Entidad que puede conectarse a una red, enviar y transmitir mensajes, ademas cuenta con una identificacion unica.
	- Info
		- id
		- peer_id
		- etiquetas
		- red en la que esta registrado (puede ser ninguna)
		- modo de comunicacion
			- rcp
			- referencia
	- Funciones
		- registrarse en red
		- desregistrarse a una red
		- enviar mensaje
		- recibir mensaje
		- aniadir etiqueta
		- eliminar etiqueta
		- actualizar peer_id
- Mensaje
	- informacion encodeada en json para ser transmitida mediante notificaciones a los nodos. Un mismo mensaje puede ser transmitido por varias notificaciones, ya que las notificaciones son nodo a nodo (1a1)
	- Info
		- id
		- contenido
- Operacion de envio
	- Representa el envio de un mensaje de un nodo a otro (1a1). Ambos nodos deben pertenecer a la misma red
	- Info
		- id
		- nodo origen
		- nodo destino
		- red
		- fecha envio
		- fecha recepcion
		- mensaje
		- estado
			- pendiente 
			- enviado
			- envio fallido


extends "res://addons/gut/test.gd"

const uuid = preload('res://tools/uuid.gd')

func test_crear_identificador():
	# Arrenge
	var nombre = "pepito"
	var id = uuid.v4()

	# Act
	var identificador = Api.CrearIdentificador(nombre, id)

	# Assert
	assert_is(identificador, Identificador)
	assert_eq(identificador.nombre, nombre)
	assert_eq(identificador.id, id)

# func test_registrar_nodo():
# 	# Arrange
# 	var identificador = crear_identificador_default()

# 	# Act
# 	var estado = Api.RegistrarNodo(identificador)

# 	# Assert
# 	assert_eq(estado, "registro enviado exito")

# func test_enviar_mesaje():
# 	# Arrange
# 	var identificador = crear_identificador_default()
# 	var msj = "this is a test"

# 	# Act
# 	Api.EnviarMensaje(msj)

# 	# Assert

	
# func crear_identificador_default() -> Identificador:
# 	var nombre = "cliente"
# 	var id = uuid.v4()
# 	var identificador = Api.CrearIdentificador(nombre, id)

# 	return identificador 

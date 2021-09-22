extends "res://addons/gut/test.gd"

const uuid = preload('res://tools/uuid.gd')

func test_crear_nodo():
	# Arrange
	var nombre_nodo = "cliente"
	var id_nodo = uuid.v4()
	var ip_nodo = "192.168.0.1"
	var puerto_nodo = "8000"

	# Act
	var nodo = Api.CrearNodo(nombre_nodo, id_nodo, ip_nodo, puerto_nodo)

	# Assert
	assert_is(nodo, Nodo)
	assert_eq(nodo.nombre, nombre_nodo)
	assert_eq(nodo.id, id_nodo)
	assert_eq(nodo.ip, ip_nodo)
	assert_eq(nodo.puerto, puerto_nodo)
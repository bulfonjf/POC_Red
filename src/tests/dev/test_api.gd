extends "res://addons/gut/test.gd"

const uuid = preload('res://tools/uuid.gd')

func test_conectar():
	var test_suite = [
		{
			"name": "conectar - conexion exitosa",
			"description": "valores validos",
			"testData": {
				"nombre":"alexis",
				"id":"134",
				"ip":"111",
				"puerto":8080
			},
			"crear_red_cliente": funcref(self, "crear_red_cliente_conectado"),
			"resultado_esperado": EstadoConexion.new(true)
		},
		{
			"name": "conectar - conexion fallida",
			"description": "valores validos, conexion sin exito",
			"testData": {
				"nombre":"alexis",
				"id":"134",
				"ip":"111",
				"puerto":8080
			},
			"crear_red_cliente": funcref(self, "crear_red_cliente_no_conectado"),
			"resultado_esperado": EstadoConexion.new(false)
		}
	]

	print("Test Cases")

	for tc in test_suite:
		print(tc.name)

		# Arrenge
		var red_cliente_mock = tc.crear_red_cliente.call_func()
		NodoCliente.Initialize(red_cliente_mock)

		# Act
		var resultado_obtenido= Api.Conectar(tc.testData.nombre, tc.testData.id, tc.testData.ip, tc.testData.puerto)

		# Assert
		assert_true(compare_estado_conexion(resultado_obtenido, tc.resultado_esperado))


func crear_red_cliente_conectado(): 
	return RedClienteMock.new(funcref(self, "red_cliente_conectar_conectado"))

func crear_red_cliente_no_conectado(): 
	return RedClienteMock.new(funcref(self, "red_cliente_conectar_no_conectado"))

func red_cliente_conectar_conectado(_ip, _puerto):
	return true

func red_cliente_conectar_no_conectado(_ip, _puerto):
	return false 

func compare_estado_conexion(obtenido, esperado) -> bool:
	return obtenido.is_connected == esperado.is_connected


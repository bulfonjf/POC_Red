extends "res://addons/gut/test.gd"

const uuid = preload('res://tools/uuid.gd')

func test_conectar():
	var test_suite = [
		{
			"nombre": "conectar - conexion exitosa",
			"descripcion": "valores validos",
			"testData": {
				"nombre":"alexis",
				"id":"134",
				"ip":"111",
				"puerto":8080
			},
			"crear_red_cliente": funcref(self, "crear_red_cliente_conectar_conectado"),
			"resultado_esperado": EstadoConexion.new(true)
		},
		{
			"nombre": "conectar - conexion fallida",
			"descripcion": "valores validos, conexion sin exito",
			"testData": {
				"nombre":"alexis",
				"id":"134",
				"ip":"111",
				"puerto":8080
			},
			"crear_red_cliente": funcref(self, "crear_red_cliente_conectar_no_conectado"),
			"resultado_esperado": EstadoConexion.new(false)
		}
	]

	print("Test Cases")

	for tc in test_suite:
		print(tc.nombre)

		# Arrenge
		var red_cliente_mock = tc.crear_red_cliente.call_func()
		NodoCliente.Inicializar(red_cliente_mock)

		# Act
		var resultado_obtenido = Api.Conectar(tc.testData.nombre, tc.testData.id, tc.testData.ip, tc.testData.puerto)

		# Assert
		assert_true(compare_estado_conexion(resultado_obtenido, tc.resultado_esperado))

func test_desconectar():
	var test_suite = [
		{
			"nombre":"Desconexion exitosa",
			"crear_red_cliente": funcref(self, "crear_red_cliente_isconectado_no_conectado"),
			"resultado_esperado": EstadoConexion.new(false)
		}
	]

	for tc in test_suite:
		print(tc.nombre)

		# Arrenge
		var red_cliente_mock = tc.crear_red_cliente.call_func()
		NodoCliente.Inicializar(red_cliente_mock)
		# Act
		var resultado_obtenido = Api.Desconectar()

		# Assert
		assert_true(compare_estado_conexion(resultado_obtenido, tc.resultado_esperado))

func crear_red_cliente_conectar_conectado(): 
	return RedClienteMock.new(funcref(self, "red_cliente_conectar_conectado"), null)

func crear_red_cliente_conectar_no_conectado(): 
	return RedClienteMock.new(funcref(self, "red_cliente_conectar_no_conectado"), null)

func crear_red_cliente_isconectado_conectado(): 
	return RedClienteMock.new(null, funcref(self, "red_cliente_isconectado_conectado"))

func crear_red_cliente_isconectado_no_conectado(): 
	return RedClienteMock.new(null, funcref(self, "red_cliente_isconectado_no_conectado"))

func red_cliente_conectar_conectado(_ip, _puerto):
	return true

func red_cliente_conectar_no_conectado(_ip, _puerto):
	return false 

func red_cliente_isconectado_conectado():
	return true

func red_cliente_isconectado_no_conectado():
	return false 

func compare_estado_conexion(obtenido, esperado) -> bool:
	return obtenido.is_connected == esperado.is_connected


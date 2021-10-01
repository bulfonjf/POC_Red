extends Node

var red_cliente
var identificador : Identificador
var red_dto : RedDTO

func Inicializar(_red_cliente):
	self.red_cliente =  _red_cliente

func Conectar(_identificador : Identificador, _red_dto : RedDTO) -> EstadoConexion:
	var is_conectado = self.red_cliente.Conectar(_red_dto.ip, _red_dto.puerto)
	return EstadoConexion.new(is_conectado)

func Desconectar() -> EstadoConexion:
	self.red_cliente.Desconectar()
	var is_conectado = self.red_cliente.IsConectado()
	return EstadoConexion.new(is_conectado)

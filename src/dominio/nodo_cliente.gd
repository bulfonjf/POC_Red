extends Node

var red_cliente
var identificador : Identificador
var red_dto : RedDTO

func Initialize(_red_cliente):
	self.red_cliente =  _red_cliente

func Conectar(_identificador : Identificador, _red_dto : RedDTO) -> EstadoConexion:
	var is_conectado = red_cliente.Conectar(_red_dto.ip, _red_dto.puerto)
	return EstadoConexion.new(is_conectado)


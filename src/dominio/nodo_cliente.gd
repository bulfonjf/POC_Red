extends Node

var red_cliente
var identificador : Identificador
var red : Red

func Initialize(_red_cliente):
	self.red_cliente =  _red_cliente

func Conectar(_identificador : Identificador, _red : Red) -> EstadoConexion:
	var is_conectado = red_cliente.Conectar(_red.ip, _red.puerto)
	return EstadoConexion.new(is_conectado)


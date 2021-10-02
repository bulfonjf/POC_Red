extends Node


func Conectar(_nombre : String, _id : String, _ip : String, _puerto : int) -> EstadoConexion:
	var identificador = Identificador.new(_nombre, _id)
	var red = RedDTO.new(_ip, _puerto)
	return NodoCliente.Conectar(identificador, red)

func Desconectar() -> EstadoConexion:
	return NodoCliente.Desconectar()

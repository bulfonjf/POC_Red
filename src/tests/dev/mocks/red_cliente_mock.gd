class_name RedClienteMock

var conectar_func

func _init(_conectar_func):
	self.conectar_func = _conectar_func

func Conectar(_identificador, _red) -> EstadoConexion:
	return self.conectar_func.call_func(_identificador, _red)

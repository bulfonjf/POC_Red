class_name RedClienteMock

var conectar_func
var is_conectado_func

func _init(_conectar_func, _is_conectado_func):
    self.conectar_func = _conectar_func
    self.is_conectado_func = _is_conectado_func

func Conectar(_identificador, _red_dto) -> EstadoConexion:
    return self.conectar_func.call_func(_identificador, _red_dto)

func Desconectar():
    pass

func IsConectado() -> EstadoConexion:
    return self.is_conectado_func.call_func()

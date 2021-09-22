extends Node

func CrearNodo(_nombre : String, _id : String, _ip : String, _puerto : String):
	return Nodo.new(_nombre, _id, _ip, _puerto)

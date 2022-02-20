extends Node2D

export var dialog_name:=""
func interact():
	var chest_dialog = Dialogic.start(dialog_name)
	add_child(chest_dialog)

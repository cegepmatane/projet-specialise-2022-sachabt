extends Node2D

enum OBJET {
	ARGENT, 
	POTION, 
	VIDE
}
export(OBJET) var objet := OBJET.VIDE
export var nombre := 0
var interacting = false

func interact():
	if !interacting:
		get_object()


func get_object():
	interacting = true
		#TODO add interaction with dialogic, maybe the chest should be talking from here
	match objet:
		OBJET.ARGENT:
			Inventory.add_money(nombre)
			Dialogic.set_variable("object_in_chest", "ARGENT")
		OBJET.POTION:
			Inventory.add_potion(nombre)
			Dialogic.set_variable("object_in_chest", "POTION")
		_:
			Dialogic.set_variable("object_in_chest", "VIDE")
	$Chest.frame = 1;
	var chest_dialog = Dialogic.start('open-chest')
	add_child(chest_dialog)

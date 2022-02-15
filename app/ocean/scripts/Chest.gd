extends Node2D

enum OBJECT {
	MONEY, 
	POTION, 
	EMPTY
}
export(OBJECT) var object := OBJECT.EMPTY
export var number := 0
var opened = false

func interact():
	if !opened:
		get_object()


func get_object():
	opened = true
	Dialogic.set_variable("number", number)
	match object:
		OBJECT.MONEY:
			Inventory.add_money(number)
			Dialogic.set_variable("object_in_chest", "MONEY")
		OBJECT.POTION:
			Inventory.add_potion(number)
			Dialogic.set_variable("object_in_chest", "POTION")
		_:
			Dialogic.set_variable("object_in_chest", "EMPTY")
	$Chest.frame = 1;
	var chest_dialog = Dialogic.start('open-chest')
	add_child(chest_dialog)

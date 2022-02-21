extends Node2D

#maybe save most things into inventory

func _ready():
	#will be displaced to the start menu later
	#call_deferred("load_game")
	pass


# Note: This can be called from anywhere inside the tree. This function is
# path independent.
# Go through everything in the persist category and ask them to return a
# dict of relevant variables.
func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	
	var current_scene = {"current_scene" : get_tree().get_current_scene().filename}
	save_game.store_line(to_json(current_scene))
	
	# Call the node's save function.
	var save_data = Inventory.save()

	# Store the save dictionary as a new line in the save file.
	save_game.store_line(to_json(save_data))
	
	#need to add a scene to store story related checks
	
	save_game.close()


# Note: This can be called from anywhere inside the tree. This function
# is path independent.
func load_game():
	var save_game = File.new()
	if has_save(save_game):
		return # Error! We don't have a save to load.

	#il faudra peut être modifier la partie suivante, en effet actuellement la fonction remplace les objets 
	#avec des objets conforme à la sauvegarde, ne marcherait donc pas forcément pour les objets qui ne sont
	#pas dans la scène
	
	#ne prends aussi pas en compte la possibilité d'avoir des objets "Persist" imbriqué

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open("user://savegame.save", File.READ)
	
	#skip the first line
	var node_data = parse_json(save_game.get_line())
	node_data = parse_json(save_game.get_line())
	for i in node_data.keys():
		Inventory.set(i, node_data[i])
	
	save_game.close()

func has_save(save_game):
	return not save_game.file_exists("user://savegame.save")

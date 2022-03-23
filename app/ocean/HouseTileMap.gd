extends TileMap

var door_area = preload("res://DoorArea.tscn")

func _ready():
	var house_tiles = get_used_cells()
	
	for tile in house_tiles:
		if get_cell(tile[0], tile[1]) == 2 :
			var door_instance = door_area.instance()
			door_instance.position = map_to_world(tile)
			add_child(door_instance)
			pass
	pass

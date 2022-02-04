extends KinematicBody2D



func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		#"current_health" : current_health,
		#"max_health" : max_health,
		#I can add anything here
	}
	return save_dict

#might have to create a load function
#need to think about it

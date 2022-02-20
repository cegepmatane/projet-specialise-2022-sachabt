extends "res://scripts/Player.gd"

export var area_size := Vector2(1020, 600)


func _physics_process(_delta):
	get_interaction()
	update_shader()


func update_shader():
	$WaterLayer/water/waterShader.material.set_shader_param("player_pos", position)
	#appliquer un vecteur/une vitesse
	#$WaterLayer/water/waterShader.material.set_shader_param("speed", base_speed)

func animate(direction):
	if(direction.x>0):
		$boat.set_frame(12)
		if(direction.y>0):
			$boat.set_frame(10)
		elif direction.y<0:
			$boat.set_frame(14)
	elif direction.x<0:
		$boat.set_frame(4)
		if(direction.y<0):
			$boat.set_frame(2)
		elif direction.y>0:
			$boat.set_frame(6)
	elif direction.y>0:
		$boat.set_frame(0)
	elif direction.y<0:
		$boat.set_frame(8)

func change_sprite_direction(direction):
	match direction:
		"up":
			$boat.set_frame(0)
		"down":
			$boat.set_frame(8)
		"right":
			$boat.set_frame(12)
		"left":
			$boat.set_frame(4)
	
func get_interaction():
	if $InteractionArea.get_overlapping_bodies().size() != 0 && Input.is_action_just_pressed("interact"):
		var new_scene_path = $InteractionArea.get_overlapping_bodies()[0].islandPath
		SceneSwitcher.change_scene(new_scene_path)
#	if Input.is_action_just_pressed("interact"):
#		get_parent().get_node("Save").save_game()

extends "res://Player.gd"

export var base_speed := 350
export var area_size := Vector2(1020, 600)
#contain the MOVEMENTS input the player is currently holding
var last_input :=  []


func _physics_process(delta):
	get_movement()
	get_interaction()

const MOVEMENTS = {
	'up': Vector2.UP,
	'left': Vector2.LEFT,
	'right': Vector2.RIGHT,
	'down': Vector2.DOWN,
}

func get_movement():
	
	#permet de gérer les touches du joueur pour que la dernière touche détermine le mouvement
	#idea from here : https://godotengine.org/qa/54325/how-to-prioritize-the-most-recent-direction-with-movement
	for directions in  MOVEMENTS.keys():
		if Input.is_action_just_pressed(directions):
			last_input.append(directions)
		if Input.is_action_just_released(directions):
			if last_input.find(directions)!=-1:
				last_input.erase(directions)
	
	var velocity = Vector2.ZERO
	if last_input.size() != 0:
		velocity = MOVEMENTS[last_input[last_input.size()-1]]
		change_sprite_direction(last_input[last_input.size()-1])
	
	velocity *= base_speed
	
	velocity = move_and_slide(velocity, Vector2.UP)
	position.x = fposmod(position.x, area_size.x)
	position.y =  fposmod(position.y, area_size.y)
	#maybe try to duplicate the world.... but overly complicated sooo just put nothing to the edge of the world
	#the background will change and the player will notice he's been teleported
	#temporary solution should be changed !!!!!



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
	#if Input.is_action_just_pressed("interact"):
	#	get_parent().get_node("Save").save_game()

extends KinematicBody2D

export var base_speed := 350

func _physics_process(delta):
	get_input()
	get_interaction()

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

func get_input():
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	
	velocity = velocity.normalized() #the vector is normalized so that the player does not go faster diagonally
	velocity *= base_speed
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	animate(velocity)

func animate(direction):
	if direction.x > 0:
		$PlayerSprite.flip_h = false
	elif direction.x < 0:
		$PlayerSprite.flip_h = true

func get_interaction():
	if Input.is_action_just_pressed("interact") && $InteractionArea.get_overlapping_bodies().size() != 0:
		pass

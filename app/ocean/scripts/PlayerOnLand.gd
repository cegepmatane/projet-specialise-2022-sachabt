extends "res://scripts/Player.gd"


var state_machine

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	#ne marche pas puisque PlayerOnBoat extends ce script mais n'a pas d'animationTree 
	#il faut créer un nouveau script héritant de player


func animate(direction):
	if direction != Vector2.ZERO:
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")
	if direction.x > 0:
		$PlayerSprite.flip_h = false
	elif direction.x < 0:
		$PlayerSprite.flip_h = true

func get_interaction():
	if Input.is_action_just_pressed("interact") && $InteractionArea.get_overlapping_bodies().size() != 0:
		$InteractionArea.get_overlapping_bodies()[0].interact()


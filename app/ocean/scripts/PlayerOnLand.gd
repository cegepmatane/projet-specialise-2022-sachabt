extends "res://scripts/Player.gd"


var state_machine

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	update_hud()
	

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
		state_machine.travel("idle")
		$InteractionArea.get_overlapping_bodies()[0].interact()
		update_hud()

func update_hud():
	$HUD.set_money(Inventory.money)

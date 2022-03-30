extends "res://scripts/Player.gd"

export var speed_increase := 1.2

var state_machine
var invincible := false

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
		#update HUD shouldn't be here !
	
	if Input.is_action_just_pressed("attack"):
		attack()
	
	if Input.is_action_just_pressed("shade") && $ShadeCooldown.time_left == 0:
		print("argh")
		shade()

func update_hud():
	$HUD.set_money(Inventory.money)
	$HUD.set_potion(Inventory.potion)

func attack():
	pass

func shade():
	$ShadeParticlesEffect.emitting = true
	speed *= speed_increase
	$PlayerSprite.modulate = Color(1,1,1,.2)
	#maybe add a shader here
	invincible = true
	$ShadeParticlesEffect.one_shot = false
	$ShadeTimer.start()
	$ShadeCooldown.start()

func _on_ShadeTimer_timeout():
	speed = base_speed
	$ShadeParticlesEffect.one_shot = true
	$PlayerSprite.modulate = Color.white
	#remove da shader here
	invincible = false

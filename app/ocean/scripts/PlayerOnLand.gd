extends "res://scripts/Player.gd"

export var speed_increase := 1.2

var state_machine
var invincible := false
export var attack_speed_penalty := .1
export var weapon_damage := 1

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
	
	if $AttackCooldown.time_left == 0 && $ShadeCooldown.time_left == 0:
		if Input.is_action_just_pressed("attack"):
			attack()
		if Input.is_action_just_pressed("shade"):
			shade()

func update_hud():
	$HUD.set_money(Inventory.money)
	$HUD.set_potion(Inventory.potion)

func attack():
	state_machine.travel("attack")
	speed*= attack_speed_penalty
	$AttackCooldown.start()

func shade():
	$ShadeParticlesEffect.emitting = true
	speed *= speed_increase
	$PlayerSprite.modulate = Color(1,1,1,.2)

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

func hurt(damage):
	Inventory.current_health -= damage
	
	if Inventory.current_health <= 0:
		#end game or something, or at least load last save, even go back to start menu
		pass

func _on_AttackArea2D_body_entered(body):
	if body.is_in_group("damageable") :
		body.hurt(weapon_damage)

func _on_AttackCooldown_timeout():
	speed = base_speed

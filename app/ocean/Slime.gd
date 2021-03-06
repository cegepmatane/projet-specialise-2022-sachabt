extends KinematicBody2D

#should extends a Parent class to himself and npc

export var speed := 100
export var lp := 1 
var target = null
export var attack_damage := 1
export var max_dist := 200
export var min_dist := 20

var path := PoolVector2Array()
var state_machine

var last_position

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	set_physics_process(false)

func _physics_process(delta):
	last_position = position
	var move_distance : float = speed * delta
	if position.distance_to(target.position) > max_dist:
		set_physics_process(false)
	elif position.distance_to(target.position) > min_dist:
		move(move_distance)
	else:
		attack()
	
	$Slime.flip_h = last_position.x - position.x > 0

func _on_DetectionArea_body_entered(body):
	print(target)
	target = body
	set_physics_process(true)
	path = get_parent().get_enemy_path(self, target)

func move(distance : float):
	state_machine.travel("")
	var last_point : = position
	for _index in range(path.size()):
		var distance_to_next = last_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = last_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif path.size() == 1 and distance >= distance_to_next:
			position = path[0]
			set_path()
			break

		distance -= distance_to_next
		last_point = path[0]
		path.remove(0)
		
		#rotate da slime plz
		print()

func set_path():
	path = get_parent().get_enemy_path(self, target)
	if path.size() == 0:
		return

func attack():
	state_machine.travel("attack")

func hurt(damage):
	lp -= damage
	#test this
	if lp <= 0:
		set_physics_process(false)
		state_machine.travel("death")
		print("should die but doesn't")

func _on_AttackArea_body_entered(body):
	if body.is_in_group("damageable") :
		body.hurt(attack_damage)

func die():
	print("yaaa")
	queue_free()

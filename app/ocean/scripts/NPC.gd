extends "res://scripts/talking_character.gd"

export var speed := 20.0
export var pointA := Vector2.ZERO
export var pointB:= Vector2.ZERO
var current_target

var path := PoolVector2Array()
var state_machine
var talking = false

var interaction_on_cooldown = false

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	state_machine.travel("idle")
	current_target = pointA
	call_deferred("set_path")
	set_process(false)

func _process(delta):
	if pointA != Vector2.ZERO and pointB != Vector2.ZERO:
		var move_distance : float = speed * delta
		move(move_distance)
		state_machine.travel("run")

func interact():
	if !interaction_on_cooldown:
		talk()
		state_machine.travel("idle")
		talking = true
		set_process(false)
		interaction_on_cooldown = true

func move(distance : float):
	var last_point : = position
	for index in range(path.size()):
		var distance_to_next = last_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = last_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif path.size() == 1 and distance >= distance_to_next:
			position = path[0]
			if current_target == pointA:
				current_target = pointB
			else:
				current_target = pointA
			set_path()
			break

		distance -= distance_to_next
		last_point = path[0]
		path.remove(0)

func dialog_end(arg):
	get_tree().paused = false
	$InteractionTimer.start()

func set_path():
	path = get_parent().get_npc_path(self)
	if path.size() ==0:
		return
	set_process(true)


func _on_InteractionTimer_timeout():
	interaction_on_cooldown = false

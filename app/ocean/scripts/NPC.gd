extends StaticBody2D

export var dialog_name:=""
export var speed := 0
export var pointA := Vector2.ZERO
export var pointB:= Vector2.ZERO
var current_target
export var steer_force := 50 #determine wether the player is going in a straight line or taking turn slowly
#should be useless I think ?!

func _ready():
	current_target = pointA

func interact():
	var chest_dialog = Dialogic.start(dialog_name)
	add_child(chest_dialog)

func move():
	var desired = (target.position - position).normalized() * speed #velocity desired to perfectly track the player
		steer = (desired - velocity).normalized() *steer_force

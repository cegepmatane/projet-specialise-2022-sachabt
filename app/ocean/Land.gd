extends Node2D

onready var nav_2d : Navigation2D = $Navigation2D

func move():
	var moving_npc = get_tree().get_nodes_in_group("moving_npc")
	for npc in moving_npc:
		var path = nav_2d.get_simple_path(npc.global_position, npc.current_target)
		npc.path = path

func get_npc_path(npc):
	return nav_2d.get_simple_path(npc.global_position, npc.current_target)

extends Node2D

func change_scene(new_scene):
	assert(get_tree().change_scene(new_scene)==OK)
	add_child(get_node("res://Player.tscn"))

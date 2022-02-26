extends Node2D


func change_scene(new_scene):
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	assert(get_tree().change_scene(new_scene)==OK)
	$AnimationPlayer.play_backwards("fade")

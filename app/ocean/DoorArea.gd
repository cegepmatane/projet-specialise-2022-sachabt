extends Area2D

var house_scene_path := ""

func interact():
	if house_scene_path != "" :
		SceneSwitcher.change_scene(house_scene_path)
	#could add a dialog if the door is closed 

extends Control

export var start_scene := "res://Main.tscn"
onready var settingsmenu = load("res://Options.tscn")

func ready():
	#the player can't load an unexisting game
	var save_game = File.new()
	if Save.has_save(save_game):
			$LoadButton.disabled = true

func _on_LoadButton_pressed():
	#here i can call load from the Save scene
	var save_game = File.new()
	save_game.open("user://savegame.save", File.READ)
	
	#I need to add a sceneSwitcher and save the scene in wich the player is
	var node_data = parse_json(save_game.get_line())
	SceneSwitcher.change_scene(node_data["current_scene"])
	
	
	Save.load_game()
	pass


func _on_StartButton_pressed():
	print("pressed start")
	SceneSwitcher.change_scene(start_scene)
	pass # Replace with function body.


func _on_settingsButton_pressed():
	add_child(settingsmenu.instance())
	get_tree().paused = true

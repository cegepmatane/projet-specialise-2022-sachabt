extends Node

onready var settingsmenu = load("res://Options.tscn")
var filepath = "res://keybinds.ini"
var configFile
var dialogue_theme_path = "res://dialogic/themes/default-theme.cfg"
var keybinds = {}

var dialogThemeFile

var music_vol := 75

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		add_child(settingsmenu.instance())
		get_tree().paused = true

func _ready():
	configFile = ConfigFile.new()
	if configFile.load(filepath) == OK:
		for key in configFile.get_section_keys("keybinds"):
			var key_value = configFile.get_value("keybinds", key)
			
			if str(key_value) != "":
				keybinds[key] = key_value
			else:
				keybinds[key] = null
		
		load_vol()
	else:
		print("CONFIG FILE NOT FOUND")
		get_tree().quit()
	
	set_game_binds()

func set_game_binds():
	for key in keybinds.keys():
		var value = keybinds[key]
		var actionlist = InputMap.get_action_list(key)
		if !actionlist.empty():
			InputMap.action_erase_event(key, actionlist[0])
		
		if value != null:
			var new_key = InputEventKey.new()
			new_key.set_scancode(value)
			InputMap.action_add_event(key, new_key)

func set_dialog_speed(text_speed):
	dialogThemeFile = ConfigFile.new()
	if dialogThemeFile.load(dialogue_theme_path) == OK:
		dialogThemeFile.set_value("text", "speed", text_speed)
		dialogThemeFile.save(dialogue_theme_path)

func read_speed():
	dialogThemeFile = ConfigFile.new()
	if dialogThemeFile.load(dialogue_theme_path) == OK:
		return dialogThemeFile.get_value("text", "speed")

func write_config():
	for key in keybinds.keys():
		var key_value = keybinds[key]
		if key_value != null:
			configFile.set_value("keybinds", key, key_value)
		else:
			configFile.set_value("keybinds", key, "")
	configFile.save(filepath)

func save_vol(vol):
	configFile.set_value("volume", "db", vol)

func load_vol():
	var vol = configFile.get_value("volume", "db")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(vol))

extends  KinematicBody2D

export var dialog_name:=""

func talk():
	var dialog = Dialogic.start(dialog_name)
	dialog.connect("dialogic_signal", self, "dialog_end")
	dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	add_child(dialog)
	self.pause_mode = Node.PAUSE_MODE_PROCESS
	get_tree().paused = true

func dialog_end(_arg):
	get_tree().paused = false

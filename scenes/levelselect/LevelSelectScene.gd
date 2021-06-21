extends Node2D

var selected_level = "none"

func _ready():
	pass

func _preview_level(level_name):
	var level = LevelLoader.load_level(1)
	
	pass

func _on_Button_toggled(button_pressed, extra_arg_0):
	for button in $LevelSelect/VBox/Scroll/List.get_children():
		if selected_level != extra_arg_0:
			selected_level = extra_arg_0
			_preview_level(selected_level)
		if button.text != extra_arg_0:
			button.pressed = false
		else:
			button.pressed = true

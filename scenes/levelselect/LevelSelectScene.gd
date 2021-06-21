extends Node2D

var selected_level

func _ready():
	_load_levels()
	pass
	
func _load_levels():
	print(LevelLoader.level_list)
	for level in LevelLoader.level_list.levels:
		var button = Button.new()
		button.toggle_mode = true
		button.clip_text = true
		button.text = level.name
		button.set_meta("id", level.id)
		button.set_meta("name", level.name)
		button.connect("toggled", self, "_on_Button_toggled", [level.id])
		$LevelSelect/VBox/Scroll/List.add_child(button)

func _preview_level(level_id):
	GameState.selected_level = LevelLoader.load_level(level_id)
	$Grid.reset()

func _on_Button_toggled(button_pressed, level_id):
	if selected_level != level_id and button_pressed:
		selected_level = level_id
		_preview_level(selected_level)
	for button in $LevelSelect/VBox/Scroll/List.get_children():
		if selected_level == button.get_meta("id"):
			button.pressed = true
		else:
			button.pressed = false

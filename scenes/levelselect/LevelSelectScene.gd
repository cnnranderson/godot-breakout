extends Node2D

const _Ball = preload("res://entities/ball/Ball.tscn")

var selected_level
var preview_ball

func _ready():
	_load_levels()
	pass

func _spawn_ball(pos):
	if preview_ball: preview_ball.queue_free()
	preview_ball = _Ball.instance()
	preview_ball.position = pos
	preview_ball.scale = Vector2.ONE / 2
	preview_ball.velocity = Vector2(2, 1).normalized() * preview_ball.speed / 2
	add_child(preview_ball)

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
	_spawn_ball(Vector2(480, 240))

func _on_Button_toggled(button_pressed, level_id):
	if selected_level != level_id and button_pressed:
		$PlayButton.disabled = false
		selected_level = level_id
		_preview_level(selected_level)
	for button in $LevelSelect/VBox/Scroll/List.get_children():
		if selected_level == button.get_meta("id"):
			button.pressed = true
		else:
			button.pressed = false

func _on_PlayButton_pressed():
	Global.main.load_scene(Global.Scenes.GAME)

func _on_BackButton_pressed():
	Global.main.load_scene(Global.Scenes.START_MENU)

extends Node2D

@export var PlayButton: Button
@export var QuitButton: Button

func _ready():
	pass

func _on_Play_pressed():
	Global.main.load_scene(Global.Scenes.LEVEL_SELECT)

func _on_Quit_pressed():
	get_tree().quit()

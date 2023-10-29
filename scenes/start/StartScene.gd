extends Node2D

@onready var PlayButton : Button = $MBox/VBox/Play
@onready var QuitButton : Button = $MBox/VBox/Quit

func _ready():
	pass

func _on_Play_pressed():
	Global.main.load_scene(Global.Scenes.LEVEL_SELECT)

func _on_Quit_pressed():
	get_tree().quit()

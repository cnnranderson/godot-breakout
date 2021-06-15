extends Control

onready var PlayButton : Button = $MBox/VBox/Play
onready var QuitButton : Button = $MBox/VBox/Quit

func _ready():
	#_animate_startup()
	pass

func _animate_startup():
	$Tween.interpolate_property(PlayButton, "rect_position:x", -600, PlayButton.rect_position.x, .5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	$Tween.interpolate_property(QuitButton, "rect_position:x", -600, QuitButton.rect_position.x, .6, Tween.TRANS_CUBIC, Tween.EASE_IN)
	$Tween.start()

func _on_Play_pressed():
	Global.main.load_scene(Global.Scenes.GAME)

func _on_Quit_pressed():
	get_tree().quit()

extends Node

enum Scenes {START_MENU, GAME}

const SceneMap = {
	Scenes.START_MENU: "res://scenes/start/StartScene.tscn",
	Scenes.GAME: "res://scenes/game/GameScene.tscn"
}
const COLORS = {
	"charcoal": "2E4052",
	"yellow": "FFC857",
	"white": "FFFFFF",
	"green": "00A6A6",
	"red": "DA5552"
}
const Palette = {
	"primary": COLORS.charcoal,
	"secondary": COLORS.yellow,
	"bricks": COLORS.yellow,
	"bricks_double": COLORS.red
}

var main : Main = null
var debug = true

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _process(_delta):
	if Input.is_action_just_pressed("enable_debug"):
		debug = !debug
	
	if debug:
		# Easy exit
		if Input.is_action_pressed("debug_quit"):
			get_tree().quit()

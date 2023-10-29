extends Node

enum Scenes {NONE, START_MENU, LEVEL_SELECT, GAME}

const SceneMap = {
	Scenes.START_MENU: "res://scenes/start/StartScene.tscn",
	Scenes.LEVEL_SELECT: "res://scenes/levelselect/LevelSelectScene.tscn",
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
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(_delta):
	if debug:
		if Input.is_action_pressed("debug_quit"):
			get_tree().quit()

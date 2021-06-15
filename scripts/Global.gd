extends Node

const COLORS = {
	"charcoal": "2E4052",
	"yellow": "FFC857",
	"white": "FFFFFF",
	"green": "00A6A6",
	"red": "DA5552"
}

var main : Main = null

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

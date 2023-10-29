extends Node

enum Level {
	TEST_LEVEL
}

const LEVEL_LIST_FILE = "res://levels/level_list.tres"
const LEVEL_FILE = "res://levels/level_%d.tres"

var level_list = []

func _ready():
	load_level_list()

func load_level_list():
	if not FileAccess.file_exists(LEVEL_LIST_FILE):
		print("Doesn't exist")
		return
	
	var list = FileAccess.open(LEVEL_LIST_FILE, FileAccess.READ)
	var test_json_conv = JSON.new()
	test_json_conv.parse(list.get_as_text())
	level_list = test_json_conv.get_data()
	list.close()

func load_level(level_id):
	if not FileAccess.file_exists(LEVEL_FILE % level_id):
		print("Level doesn't exist: %d" % level_id)
		return
	
	var level = FileAccess.open(LEVEL_FILE % level_id, FileAccess.READ)
	var test_json_conv = JSON.new()
	test_json_conv.parse(level.get_as_text())
	var level_data = test_json_conv.get_data()
	level.close()
	print("Loaded level: %s" % level_id)
	return level_data

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
	var list = FileAccess.open(LEVEL_LIST_FILE, FileAccess.READ)
	if not list.file_exists(LEVEL_LIST_FILE):
		print("Doesn't exist")
		return
	
	var test_json_conv = JSON.new()
	test_json_conv.parse(list.get_as_text())
	level_list = test_json_conv.get_data()
	list.close()

func load_level(level_id):
	var level = FileAccess.open(LEVEL_FILE % level_id, FileAccess.READ)
	if not level.file_exists(LEVEL_FILE % level_id):
		print("Level doesn't exist: %d" % level_id)
		return
	
	var test_json_conv = JSON.new()
	test_json_conv.parse(level.get_as_text())
	var level_data = test_json_conv.get_data()
	level.close()
	print("Loaded level: %s" % level_id)
	return level_data

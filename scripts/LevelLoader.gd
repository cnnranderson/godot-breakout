extends Node

enum Level {
	TEST_LEVEL
}

const LEVEL_LIST_FILE = "res://levels/level_list.tres"
const LEVEL_FILE = "res://levels/level_%d.tres"

var level_list = []

func load_level_list():
	var list = File.new()
	if not list.file_exists(LEVEL_LIST_FILE):
		print("Doesn't exist")
		return
	
	list.open(LEVEL_LIST_FILE, File.READ)
	level_list = parse_json(list.get_as_text())
	list.close()

func load_level(level_id):
	var level = File.new()
	if not level.file_exists(LEVEL_FILE % level_id):
		print("Level doesn't exist: %d" % level_id)
		return
	
	level.open(LEVEL_FILE % level_id, File.READ)
	var level_data = parse_json(level.get_as_text())
	level.close()
	print("Loaded level: %s" % level.name)
	return level_data

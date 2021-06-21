extends Node

enum Level {
	TEST_LEVEL
}

var Levels = {
	Level.TEST_LEVEL: "res://levels/level_1.tres"
}

func load_level(level_name):
	assert(level_name in Level.values())
	
	# "res://levels/level_%s.tres", % 
	var level = File.new()
	if not level.file_exists(Levels[level_name]):
		print(Levels[level_name])
		print("Doesn't exist")
		return
	
	level.open(Levels[level_name], File.READ)
	var level_data = parse_json(level.get_as_text())
	level.close()
	return level_data

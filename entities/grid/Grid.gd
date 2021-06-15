extends Node2D
class_name Grid

const _Brick = preload("res://entities/brick/Brick.tscn")

var grid = []
var bricks_left = 0

func _ready():
	Events.connect("brick_destroyed", self, "_Event_brick_destroyed")

func reset():
	_init_grid()

func _init_grid():
	grid = []
	for i in range(5):
		grid.append([])
		for j in range(15):
			var b = _create_brick(Vector2(j, i))
			grid[i].append(b)
			bricks_left += 1
			$Bricks.add_child(b)
	pass

func _create_brick(coord):
	var brick = _Brick.instance()
	brick.grid_coord = coord
	brick.position = Vector2(coord.x * 40 + 80, coord.y * 20 + 40)
	brick.hp = 2 if randf() > .75 else 1
	return brick

func _Event_brick_destroyed(points, coordinate):
	bricks_left -= 1
	
	if bricks_left == 0:
		Events.emit_signal("game_won")

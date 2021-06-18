extends Node2D
class_name Grid

const _Brick = preload("res://entities/brick/Brick.tscn")

export(Vector2) var grid_size = Vector2(15, 5)
var grid = []
var bricks_left = 0

func _ready():
	Events.connect("brick_destroyed", self, "_Event_brick_destroyed")

func reset():
	_init_grid()

func _init_grid():
	grid = []
	for i in range(grid_size.y):
		grid.append([])
		for j in range(grid_size.x):
			var b = _create_brick(Vector2(j, i))
			grid[i].append(b)
			bricks_left += 1
			$Bricks.add_child(b)

func _create_brick(coord):
	var brick = _Brick.instance()
	brick.grid_coord = coord
	brick.position = Vector2(coord.x * 40 + 85, coord.y * 25 + 40)
	brick.hp = 2 if Helpers.chance_luck(25) else 1
	return brick

func _Event_brick_destroyed(points, coordinate):
	bricks_left -= 1
	
	if bricks_left == 0:
		Events.emit_signal("game_won")

extends Node2D
class_name Grid

const _Brick = preload("res://entities/brick/Brick.tscn")

@export var grid_size: Vector2 = Vector2(16, 8)

var grid = []
var bricks_left = 0
var x_bounds = -320
var y_bounds = -100

func _ready():
	Events.brick_destroyed.connect(_Event_brick_destroyed)

func reset():
	_init_grid()

func _init_grid():
	if not GameState.selected_level:
		return
	
	var bricks = $Bricks.get_children()
	for brick in bricks:
		brick.queue_free()
	
	var level = GameState.selected_level
	grid_size = Vector2(level.columns, level.rows)
	
	grid = []
	for i in range(grid_size.y):
		grid.append([])
		for j in range(grid_size.x):
			var hp = 1
			if level.has("pattern"):
				if level.pattern[i][j] == "0": continue
				hp = int(level.pattern[i][j])
			var b = _create_brick(Vector2(j, i), hp)
			grid[i].append(b)
			bricks_left += 1
			$Bricks.add_child(b)

func _create_brick(coord, hp):
	var brick = _Brick.instantiate()
	brick.grid_coord = coord
	brick.position = Vector2(coord.x * (640.0 / (grid_size.x - 1)) + x_bounds, \
							coord.y * (200.0 / (grid_size.y - 1)) + y_bounds)
	brick.hp = hp
	brick.powerup = Powerup.MULTI if Helpers.chance_luck(50) else Powerup.GROW_BALL
	return brick

func _Event_brick_destroyed(points, coordinate):
	bricks_left -= 1
	
	if bricks_left == 0:
		Events.emit_signal("game_won")

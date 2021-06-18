extends Node2D
class_name Brick

const COLOR_SINGLE = Color(Global.Palette.bricks)
const COLOR_DOUBLE = Color(Global.Palette.bricks_double)

export(bool) var is_moving = false
export(int) var points = 50
export(int) var hp = 1

var grid_coord = Vector2(0, 0)

func _ready():
	set_meta("type", "brick")

func _process(delta):
	var color = COLOR_SINGLE if hp < 2 else COLOR_DOUBLE
	$Sprite.material.set_shader_param("SelectedColor", color)

func hit():
	if hp > 0:
		hp -= 1
	
	if hp == 0:
		Events.emit_signal("brick_destroyed", points, grid_coord)
		queue_free()

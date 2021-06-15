extends Node2D
class_name Brick

export(bool) var is_moving = false
export(int) var points = 50

func _ready():
	$Sprite.material.set_shader_param("SelectedColor", Color(Global.Palette.bricks))

func hit():
	queue_free()

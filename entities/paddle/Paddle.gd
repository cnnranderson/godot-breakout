extends KinematicBody2D
class_name Paddle

export(int) var speed = 20
export(int) var start_y = 580

onready var width = $Sprite.texture.get_width() * scale.x

var velocity = Vector2()
var target = Vector2()

func _ready():
	set_meta("type", "paddle")
	$Sprite.material.set_shader_param("SelectedColor", Color(Global.Palette.secondary))

func _process(delta):
	target = get_global_mouse_position()

func _physics_process(delta):
	position.x = lerp(position.x, target.x, speed * delta)
	position.x = clamp(position.x, width / 2, 720 - width / 2)
	position.y = start_y

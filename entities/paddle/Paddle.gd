extends KinematicBody2D

export(int) var speed = 800
export(int) var start_y = 440

onready var width = $Sprite.texture.get_width() * scale.x

var velocity = Vector2()
var target = Vector2()

func _ready():
	set_meta("type", "paddle")
	$Sprite.material.set_shader_param("SelectedColor", Color(Global.Palette.secondary))

func _input(event):
	target = get_global_mouse_position()

func _physics_process(delta):
	position.y = start_y
	velocity = position.direction_to(target) * speed
	velocity = move_and_slide(velocity)
	
	position.x = clamp(position.x, width / 2, 720 - width / 2)
	position.y = start_y

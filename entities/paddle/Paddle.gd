extends CharacterBody2D
class_name Paddle

@export var speed: int = 20
@export var start_y: int = 580

@onready var width = $Sprite2D.texture.get_width() * scale.x

var target = Vector2()

func _ready():
	set_meta("type", "paddle")
	$Sprite2D.material.set_shader_parameter("SelectedColor", Color(Global.Palette.secondary))

func _process(delta):
	target = get_global_mouse_position()

func _physics_process(delta):
	position.x = lerp(position.x, target.x, speed * delta)
	position.x = clamp(position.x, width / 2, 720 - width / 2)
	position.y = start_y

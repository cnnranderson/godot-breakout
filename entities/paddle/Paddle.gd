extends KinematicBody2D
class_name Paddle

export(int) var speed = 2000
export(int) var start_y = 440

onready var width = $Sprite.texture.get_width() * scale.x

var velocity = Vector2()
var target = Vector2()

func _ready():
	set_meta("type", "paddle")
	$Sprite.material.set_shader_param("SelectedColor", Color(Global.Palette.secondary))

func _process(delta):
	target = get_global_mouse_position()
	# scale = Vector2(3, max((speed - abs(velocity.x)) / speed * 3, .25))

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	velocity = move_and_slide(velocity)
	
	position.x = clamp(position.x, width / 2, 720 - width / 2)
	position.y = start_y
	width

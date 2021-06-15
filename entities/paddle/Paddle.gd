extends KinematicBody2D

export(int) var speed = 800
export(int) var start_y = 440

var velocity = Vector2()
var target = Vector2()
onready var width = $Sprite.texture.get_width() * scale.x

func _ready():
	$Sprite.material.set_shader_param("SelectedColor", Color(Global.Palette.secondary))

func _input(event):
	target = get_global_mouse_position()

func _physics_process(delta):
	position.y = start_y
	velocity = position.direction_to(target) * speed
	velocity.y = 0
	velocity = move_and_slide(velocity)
	
	position.x = clamp(position.x, width / 2, 720 - width / 2)

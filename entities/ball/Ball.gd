extends KinematicBody2D
class_name Ball

export(int) var max_speed = 400
export(int) var min_speed = 350

var velocity = Vector2(min_speed / 2, min_speed)

func _ready():
	$Sprite.material.set_shader_param("SelectedColor", Color(Global.Palette.secondary))

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var obj = collision.collider
		print(obj.get_meta("Type"))
		if obj.name == "Paddle" or obj.name == "Walls":
			velocity = velocity.bounce(collision.normal)
		if obj.get_meta("type") == "brick":
			velocity = velocity.bounce(collision.normal)
			if obj.has_method("hit"):
				obj.hit()

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	Events.emit_signal("ball_destroyed")
	queue_free()

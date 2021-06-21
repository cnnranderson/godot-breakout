extends Sprite
class_name Powerup

const MULTI = "res://entities/powerup/MultiBall.tscn"
const GROW_BALL = "res://entities/powerup/GrowBall.tscn"
const GROW_PADDLE = "res://entities/powerup/GrowBall.tscn"

enum Type {MULTI, GROW_BALL, GROW_PADDLE, NONE}

export var drop_speed = 2.0
export(Type) var type = Type.NONE

func _process(delta):
	position.y += drop_speed * delta
	drop_speed = lerp(drop_speed, 400.0, 0.01)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	if body is Paddle and type != Type.NONE:
		Events.emit_signal("powerup_obtained", self, position)
		queue_free()

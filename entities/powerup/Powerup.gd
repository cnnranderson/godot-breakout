extends Sprite
class_name Powerup

export var drop_speed = 2.0
export(String, "Multi", "Grow_Ball", "Grow_Paddle", "None") var type : String = "None"

func _process(delta):
	position.y += drop_speed * delta
	drop_speed = lerp(drop_speed, 400.0, 0.01)

func trigger_powerup():
	print("Powerup Undefined")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	if body is Paddle and type != "None":
		Events.emit_signal("powerup_obtained", self, position)
		queue_free()

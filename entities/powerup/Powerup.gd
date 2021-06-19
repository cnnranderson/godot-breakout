extends Sprite
class_name Powerup

export var drop_speed = 2.0
export(String, "Multi", "Large", "None") var type : String = "None"

func _process(delta):
	if Engine.editor_hint:
		return
	position.y += drop_speed * delta
	drop_speed = lerp(drop_speed, 400.0, 0.01)

func trigger_powerup():
	print("powerup_triggered")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	if body is Paddle:
		Events.emit_signal("powerup_obtained", self, position)
		queue_free()

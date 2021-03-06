extends KinematicBody2D
class_name Ball

const SFX_NORMAL = "res://sounds/ball_normal.wav"

export(int) var speed = 350

onready var width = $Sprite.texture.get_width() * scale.x

var hit_chain = 0
var velocity = Vector2(0, 1).normalized() * speed

func _ready():
	$Sprite.material.set_shader_param("SelectedColor", Color(Global.Palette.secondary))

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var obj = collision.collider
		
		# Flip and consume the remaining velocity
		velocity = velocity.bounce(collision.normal)
		var reflect = collision.remainder.bounce(collision.normal)
		move_and_collide(reflect)
		
		# Inform objects they were hit
		match obj.get_meta("type"):
			"brick":
				hit_chain += 1
				var pitch_shift = min(hit_chain / 2.0, 6) + 1
				Sounds.play_sound(Sounds.SoundType.SFX, SFX_NORMAL, pitch_shift)
				if obj.has_method("hit"):
					obj.hit()
			"paddle":
				hit_chain = 0
				velocity = -position.direction_to(obj.position) * speed
				Sounds.play_sound(Sounds.SoundType.SFX, SFX_NORMAL)
			_:
				Events.emit_signal("screen_shake")
				Sounds.play_sound(Sounds.SoundType.SFX, SFX_NORMAL)

func grow():
	$Tween.interpolate_property(self, "scale", scale, Vector2.ONE * 4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	$ScaleTimer.start()

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	Events.emit_signal("ball_destroyed")
	queue_free()

func _on_ScaleTimer_timeout():
	$Tween.interpolate_property(self, "scale", scale, Vector2.ONE * 1.5, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

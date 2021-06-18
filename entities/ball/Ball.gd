extends KinematicBody2D
class_name Ball

const SFX_NORMAL = "res://sounds/ball_normal.wav"

export(int) var speed = 400

var velocity = Vector2(1, 2).normalized() * speed
var hit_chain = 0

func _ready():
	$Sprite.material.set_shader_param("SelectedColor", Color(Global.Palette.secondary))

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var obj = collision.collider
		
		# Bounce velocity
		velocity = velocity.bounce(collision.normal)
		
		# Flip and consume the remaining velocity
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
				Sounds.play_sound(Sounds.SoundType.SFX, SFX_NORMAL)
			_:
				Sounds.play_sound(Sounds.SoundType.SFX, SFX_NORMAL)
			

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	Events.emit_signal("ball_destroyed")
	queue_free()

extends Node2D

const _Ball = preload("res://entities/ball/Ball.tscn")

var active_balls = 0

func _ready():
	Events.brick_destroyed.connect(_Event_brick_destroyed)
	Events.ball_destroyed.connect(_Event_ball_destroyed)
	Events.powerup_obtained.connect(_Event_powerup_obtained)
	Events.powerup_dropped.connect(_Event_powerup_dropped)
	# Events.game_lost.connect(_Event_game_lost)
	# Events.game_won.connect(_Event_game_won)
	
	$Hud/StartCountdownLabel.material.set_shader_parameter("SelectedColor", Color(Global.Palette.secondary))
	$Timers/StartTimer.start()

func _process(delta):
	if Input.is_action_just_pressed("ui_up") and Global.debug:
		_spawn_ball(get_global_mouse_position())
	
	$Hud/StartCountdownLabel.text = str(ceil($Timers/StartTimer.time_left))

func _spawn_ball(pos):
	active_balls += 1
	var ball = _Ball.instantiate()
	ball.position = pos
	$Balls.add_child(ball)

func _Event_brick_destroyed(points, coordinate):
	GameState.total_score += points
	$Hud/Score/Value.text = str("%05d" % GameState.total_score)

func _Event_ball_destroyed():
	# Test code change...?
	active_balls -= 1

func _Event_powerup_obtained(powerup : Powerup, pos):
	match powerup.type:
		Powerup.Type.MULTI: 
			pos.y -= 10
			_spawn_ball(pos)
		Powerup.Type.GROW_BALL:
			for ball in $Balls.get_children():
				ball.grow()

func _Event_powerup_dropped(powerup, pos):
	var pow_item = load(powerup).instantiate()
	pow_item.position = pos
	add_child(pow_item)

func _on_StartTimer_timeout():
	$Grid.reset()
	_spawn_ball(Vector2(360, 340))
	$Hud/StartCountdownLabel.visible = false

func _on_BackButton_pressed():
	Global.main.load_scene(Global.Scenes.LEVEL_SELECT)

extends Node2D

const _Ball = preload("res://entities/ball/Ball.tscn")

var active_balls = 0

func _ready():
	Events.connect("brick_destroyed", self, "_Event_brick_destroyed")
	Events.connect("ball_destroyed", self, "_Event_ball_destroyed")
	Events.connect("game_lost", self, "_Event_game_lost")
	Events.connect("game_won", self, "_Event_game_won")
	Events.connect("powerup_obtained", self, "_Event_powerup_obtained")
	Events.connect("powerup_dropped", self, "_Event_powerup_dropped")
	
	$Hud/StartCountdownLabel.material.set_shader_param("SelectedColor", Color(Global.Palette.secondary))
	$Timers/StartTimer.start()

func _process(delta):
	if Input.is_action_just_pressed("ui_up") and Global.debug:
		_spawn_ball(get_global_mouse_position())
	
	$Hud/StartCountdownLabel.text = str(ceil($Timers/StartTimer.time_left))

func _spawn_ball(pos):
	active_balls += 1
	var ball = _Ball.instance()
	ball.position = pos
	$Balls.add_child(ball)

func _Event_brick_destroyed(points, coordinate):
	GameState.total_score += points
	$Hud/Score/Value.text = str("%05d" % GameState.total_score)

func _Event_ball_destroyed():
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
	var pow_item = load(powerup).instance()
	pow_item.position = pos
	add_child(pow_item)

func _on_StartTimer_timeout():
	$Grid.reset()
	_spawn_ball(Vector2(360, 240))
	$Hud/StartCountdownLabel.visible = false

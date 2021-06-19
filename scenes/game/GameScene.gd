extends Node2D

const _Ball = preload("res://entities/ball/Ball.tscn")

var active_ball : Ball

func _ready():
	Events.connect("brick_destroyed", self, "_Event_brick_destroyed")
	Events.connect("ball_destroyed", self, "_Event_ball_destroyed")
	Events.connect("game_lost", self, "_Event_game_lost")
	Events.connect("game_won", self, "_Event_game_won")
	$Hud/StartCountdownLabel.material.set_shader_param("SelectedColor", Color(Global.Palette.secondary))
	$Timers/StartTimer.start()

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		_spawn_ball(get_global_mouse_position())
	
	$Hud/StartCountdownLabel.text = str(ceil($Timers/StartTimer.time_left))

func _spawn_ball(pos):
	if !is_instance_valid(active_ball) or true:
		var ball = _Ball.instance()
		ball.position = pos
		active_ball = ball
		add_child(ball)

func _Event_brick_destroyed(points, coordinate):
	print("Brick destroyed for %s points" % str(points))

func _on_StartTimer_timeout():
	$Grid.reset()
	_spawn_ball(Vector2(360, 240))
	$Hud/StartCountdownLabel.visible = false

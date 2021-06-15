extends Node2D

const _Ball = preload("res://entities/ball/Ball.tscn")

var active_ball : Ball

func _ready():
	Events.connect("brick_destroyed", self, "_Event_brick_destroyed")
	Events.connect("ball_destroyed", self, "_Event_ball_destroyed")
	Events.connect("game_lost", self, "_Event_game_lost")
	Events.connect("game_won", self, "_Event_game_won")

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		_spawn_ball()

func _spawn_ball():
	if !is_instance_valid(active_ball):
		var pos = get_global_mouse_position()
		var ball = _Ball.instance()
		ball.position = pos
		active_ball = ball
		add_child(ball)

func _Event_brick_destroyed(points, coordinate):
	print("Brick destroyed for %s points" % str(points))


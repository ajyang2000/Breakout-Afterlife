extends "res://Assets/Scripts/Paddle/Paddle.gd"

func _ready():
	GameManager.enemy_paddle = self

func _handle_movement():
	_move_by_follow_ball()

func _move_by_follow_ball():
	if !GameManager.is_balls_running:
		return
	var ball = GameManager.enemy_ball
	var x_distance = abs(ball.global_position.x - global_position.x)
	var is_ball_behind = ball.global_position.y < global_position.y - 30
	
	if ball != null and x_distance > 12.0 or is_ball_behind:
		var multiplier = -1 if ball.position.x > position.x else 1
		if is_ball_behind:
			multiplier *= -1
		
		_velocity.x = multiplier * acceleration * speed

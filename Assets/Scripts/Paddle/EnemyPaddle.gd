extends "res://Assets/Scripts/Paddle/Paddle.gd"

func _ready():
	GameManager.enemy_paddle = self
func _handle_movement():
	_move_by_follow_ball()

func _move_by_follow_ball():
	var ball = GameManager.enemy_ball
	if ball != null:
		var multiplier = -1 if ball.position.x > position.x else 1
		_velocity.x = multiplier * acceleration * speed

extends "res://Assets/Scripts/Paddle/Paddle.gd"

func _handle_movement():
	if Input.is_action_pressed("move_left"):
		_velocity.x = -acceleration * speed
	elif Input.is_action_pressed("move_right"):
		_velocity.x = acceleration * speed

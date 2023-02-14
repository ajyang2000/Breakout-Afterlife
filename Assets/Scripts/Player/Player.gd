extends KinematicBody2D

export var acceleration = 500
export var friction = 200

var _velocity = Vector2.ZERO

func _physics_process(delta):
	if Input.is_action_pressed("move_left"):
		_velocity.x = -acceleration
	elif Input.is_action_pressed("move_right"):
		_velocity.x = acceleration
		
	move_and_slide(_velocity)
	_velocity = _velocity.move_toward(Vector2.ZERO, friction)

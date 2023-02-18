extends KinematicBody2D

export var acceleration = 500
export var friction = 200
export var player_length = 5

var _velocity = Vector2.ZERO
var _y_position = 0

signal control_action
signal control_back
signal control_start

func _ready():
	PlayerData.player = self
	PlayerData.player_width = 96
	_y_position = position.y

func _physics_process(delta):
	clamp_y_position()
	if Input.is_action_pressed("move_left"):
		_velocity.x = -acceleration
	elif Input.is_action_pressed("move_right"):
		_velocity.x = acceleration
		
	move_and_slide(_velocity)
	_velocity = _velocity.move_toward(Vector2.ZERO, friction)
	
	if Input.is_action_just_pressed("action"):
		emit_signal("control_action")
	
	if Input.is_action_just_pressed("start"):
		emit_signal("control_start")

func clamp_y_position():
	position.y = _y_position

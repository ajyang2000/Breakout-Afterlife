extends KinematicBody2D

const acceleration = 500
const friction = 200

export var slots: int = 0
export var speed: int = 1

var _velocity = Vector2.ZERO
var _y_position = 0

func _ready():
	PlayerData.player = self
	PlayerData.player_width = 96
	_y_position = position.y

func _physics_process(delta):
	clamp_y_position()
	
	_handle_movement()
		
	move_and_slide(_velocity)
	_velocity = _velocity.move_toward(Vector2.ZERO, friction)

func _handle_movement():
	pass

func clamp_y_position():
	position.y = _y_position

extends KinematicBody2D

const player_container = preload("res://Assets/Prefabs/Player/PlayerContainer.tres")
const player_cell_width = 16 # pixel width of each cell

export var acceleration = 500
export var friction = 200
export var player_length = 5

onready var _player_map = $PlayerMap

var _velocity = Vector2.ZERO
var _y_position = 0

func _ready():
	_build_player(player_length)
	player_container.player = self
	player_container.player_width = player_length * player_cell_width
	_y_position = position.y

func _physics_process(delta):
	clamp_y_position()
	if Input.is_action_pressed("move_left"):
		_velocity.x = -acceleration
	elif Input.is_action_pressed("move_right"):
		_velocity.x = acceleration
		
	move_and_slide(_velocity)
	_velocity = _velocity.move_toward(Vector2.ZERO, friction)

func _build_player(length):
	assert(length >= 5, "ERROR: Length must be at least size 5")
	
	var sizeIndex = 0
	var left_end_part = 0
	var left_middle_part = 1
	var middle_part = 2
	var right_middle_part = 3
	var right_end_part = 4
	
	_player_map.set_cell(sizeIndex, 0, left_end_part)
	_player_map.set_cell(sizeIndex + 1, 0, left_middle_part)
	sizeIndex += 1
	for i in range(2, length - 2):
		sizeIndex += 1
		_player_map.set_cell(sizeIndex, 0, middle_part)
	_player_map.set_cell(sizeIndex + 1, 0, right_middle_part)
	_player_map.set_cell(sizeIndex + 2, 0, right_end_part)

func clamp_y_position():
	position.y = _y_position

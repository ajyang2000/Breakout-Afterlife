extends "res://Assets/Scripts/Ball/Ball.gd"

func _ready():
	._ready()
	GameManager.enemy_ball = self
	_direction = -_initial_direction

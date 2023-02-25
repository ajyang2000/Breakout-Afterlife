extends Node2D

func _ready():
	GameManager.is_level_done = false
	
func _on_level_done():
	GameManager.is_balls_running = false
	GameManager.is_level_done = true

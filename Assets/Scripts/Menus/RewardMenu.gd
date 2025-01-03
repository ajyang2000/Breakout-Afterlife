extends "res://Assets/Scripts/Menus/Menu.gd"

const inventory = preload("res://Assets/Configs/Inventory.tres")

@onready var sprite = $RewardsOverlay/Sprite2D

func _on_level_done():
	visible = true
	sprite.frame = inventory.get_random_reward()
	sprite.visible = true


func _go_to_next_level():
	GameManager.level_won()

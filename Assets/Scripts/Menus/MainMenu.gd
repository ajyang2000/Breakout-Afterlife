extends Node2D

onready var title_text = $MarginContainer/VBoxContainer/Title
onready var inventory = $MarginContainer/VBoxContainer/VBoxContainer/Inventory
onready var shop = $MarginContainer/VBoxContainer/VBoxContainer/Shop

func _ready():
	title_text.text = GameManager.get_title()
	if (GameManager.is_afterlife):
		inventory.visible = true
		shop.visible = true
	else:
		inventory.visible = false
		shop.visible = false
	GameManager.reset_progress()

func _start_game():
	if (GameManager.is_afterlife):
		SceneTransition.change_scene(SceneTransition.main_game_scene)
	else:
		SceneTransition.change_scene(SceneTransition.classic_game_scene)

func _go_to_credits():
	SceneTransition.change_scene(SceneTransition.credits_scene)
	
func _quit_game():
	get_tree().quit()

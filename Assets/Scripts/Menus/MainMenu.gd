extends Node2D

var _main_scene = "res://Scenes/Main.tscn"

onready var title_text = $MarginContainer/VBoxContainer/Title
onready var inventory = $MarginContainer/VBoxContainer/VBoxContainer/Inventory
onready var shop = $MarginContainer/VBoxContainer/VBoxContainer/Shop

func _ready():
	title_text.text = GameUtility.get_title()
	if (GameUtility.is_afterlife):
		inventory.visible = true
		shop.visible = true
	else:
		inventory.visible = false
		shop.visible = false

func _start_game():
	SceneTransition.change_scene(_main_scene)

func _quit_game():
	get_tree().quit()

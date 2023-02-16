extends Control

var _main_scene = "res://Scenes/Main.tscn"

func _ready():
	visible = false
	
func _go_to_main_game_scene():
	get_tree().change_scene(_main_scene)

func _on_restart_button_pressed():
	_go_to_main_game_scene()

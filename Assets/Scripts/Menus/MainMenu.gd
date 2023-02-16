extends Node2D

var _main_scene = "res://Scenes/Main.tscn"

func _start_game():
	get_tree().change_scene(_main_scene)


extends Control

var _main_scene = "res://Scenes/Main.tscn"

func _ready():
	visible = false

func _on_restart_button_pressed():
	get_tree().change_scene(_main_scene)

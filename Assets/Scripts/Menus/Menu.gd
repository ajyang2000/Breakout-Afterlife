extends Control

const main_game_scene = "res://Scenes/Main.tscn"
const main_menu_scene = "res://Scenes/Menus/MainMenu.tscn"

func _ready():
	visible = false
	
func _go_to_main_game_scene():
	get_tree().change_scene(main_game_scene)

func _on_restart_button_pressed():
	_go_to_main_game_scene()
	
func change_scene(target: String):
	SceneTransition.change_scene(target)

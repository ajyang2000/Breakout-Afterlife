extends Control

func _ready():
	visible = false
	
func _go_to_main_game_scene():
	SceneTransition.change_scene(SceneTransition.main_game_scene)
	
func _go_to_main_menu_scene():
	SceneTransition.change_scene(SceneTransition.main_menu_scene)

func _on_restart_button_pressed():
	get_tree().reload_current_scene()

func _quit_game():
	get_tree().quit()
	
func change_scene(target: String):
	SceneTransition.change_scene(target)

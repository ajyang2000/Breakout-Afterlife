extends Control

var _is_paused = false

func _ready():
	set_is_paused(false)

func set_is_paused(value):
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused

func get_is_paused():
	return _is_paused

func _on_ResumeButton_pressed():
	set_is_paused(false)

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_MainMenuButton_pressed():
	set_is_paused(false)
	SceneTransition.change_scene_to_file(SceneTransition.main_menu_scene)

func _on_paused_pressed():
	set_is_paused(!_is_paused)


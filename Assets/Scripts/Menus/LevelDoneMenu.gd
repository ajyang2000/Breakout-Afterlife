extends "res://Assets/Scripts/Menus/Menu.gd"

func _on_level_done():
	visible = true
	
func _go_to_next_level():
	GameManager.level_won()

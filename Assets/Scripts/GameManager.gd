extends Node

const simple_title = "Breakout"
const special_title = "Breakout: Afterlife"
const brick_width = 56
const brick_height = 32
const classic_level_threshold = 3
const afterlife_level_threshold = 3
const defeated_boss_threshold = 1

var is_afterlife = false
var level : int = 1 setget , get_level

func get_level():
	return level

func get_title() -> String:
	return special_title if is_afterlife else simple_title
	
func level_lost():
	# For now, go back to main menu.
	SceneTransition.change_scene(SceneTransition.main_menu_scene)

func level_won():
	level += 1
	if is_afterlife:
		# For now, reload the scene
		SceneTransition.change_scene(SceneTransition.main_game_scene)
	else:
		if (level > classic_level_threshold):
			SceneTransition.change_scene(SceneTransition.credits_scene)
			level = 1
		else:
			SceneTransition.change_scene(SceneTransition.classic_game_scene)
		

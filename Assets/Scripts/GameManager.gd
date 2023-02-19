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
var _boss_defeated_count = 0

var enemy_paddle = null
var enemy_ball = null
var is_balls_running = false
var is_level_done = true

func get_level():
	return level

func get_title() -> String:
	return special_title if is_afterlife else simple_title
	
func level_lost():
	# For now, go back to main menu.
	SceneTransition.change_scene(SceneTransition.main_menu_scene)

func level_won():
	if get_tree().current_scene.filename == SceneTransition.boss_game_scene:
		# boss defeated
		_boss_defeated_count += 1
		if (_boss_defeated_count >= defeated_boss_threshold):
			SceneTransition.change_scene(SceneTransition.credits_scene)
		else:
			level += 1
			SceneTransition.change_scene(SceneTransition.main_game_scene)
	elif is_afterlife:
		# For now, reload the scene
		SceneTransition.change_scene(SceneTransition.main_game_scene)
		if level % 3 == 0:
			SceneTransition.change_scene(SceneTransition.boss_game_scene)
		else:
			level += 1
			SceneTransition.change_scene(SceneTransition.main_game_scene)
	else:
		level += 1
		if (level > classic_level_threshold):
			SceneTransition.change_scene(SceneTransition.credits_scene)
			reset_progress()
		else:
			SceneTransition.change_scene(SceneTransition.classic_game_scene)
	print(level)

func reset_progress():
	level = 1
	_boss_defeated_count = 0

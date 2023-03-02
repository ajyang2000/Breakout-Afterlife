extends Node

const simple_title = "Breakout"
const special_title = "Breakout: Afterlife"
const brick_width = 56
const brick_height = 32
const classic_level_threshold = 3
const afterlife_level_threshold = 3
const defeated_boss_threshold = 3

var is_afterlife setget set_afterlife, get_afterlife
var level : int = 1 setget , get_level
var boss_defeated_count = 0

var enemy_paddle = null
var enemy_ball = null
var is_balls_running = false
var is_level_done = true

func _ready():
	SaveManager.load_data()

func get_level():
	return level

func get_title() -> String:
	return special_title if get_afterlife() else simple_title
	
func set_afterlife(value):
	is_afterlife = value
	SaveManager.data.is_afterlife = value
	SaveManager.save_data()
	
func get_afterlife():
	SaveManager.load_data()
	is_afterlife = SaveManager.data.is_afterlife
	return is_afterlife
	
func level_lost():
	# For now, go back to main menu.
	SceneTransition.change_scene(SceneTransition.main_menu_scene)

func level_won():
	if get_tree().current_scene.filename == SceneTransition.boss_game_scene:
		# boss defeated
		boss_defeated_count += 1
		if (boss_defeated_count >= defeated_boss_threshold):
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

func reset_progress():
	level = 1
	boss_defeated_count = 0

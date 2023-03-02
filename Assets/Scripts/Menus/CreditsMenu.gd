extends "res://Assets/Scripts/Menus/Menu.gd"

onready var _container = $VBoxContainer
onready var _end_credits = $VBoxContainer/End
onready var _full_credits = $VBoxContainer/FullCredits
onready var _end_hint = $VBoxContainer/End/EndHint

export var speed = 200
export var delay_time = 1
export var action_delay_time = 2

var _is_at_end_credits = false
var _time_elapsed = 0
var _is_hint_shown = false

func _ready():
	visible = true
	_full_credits.visible = GameManager.is_afterlife
	if GameManager.is_afterlife:
		AudioManager.play_music(AudioManager.MusicType.TRUE_CREDITS)
	else:
		AudioManager.play_music(AudioManager.MusicType.CLASSIC_CREDITS)
	_end_hint.visible = false

func _physics_process(delta):
	_time_elapsed += delta
	if _is_at_end_credits:
		if Input.is_action_just_pressed("action"):
			if SceneTransition.previous_scene == SceneTransition.main_menu_scene:
				change_scene(SceneTransition.main_menu_scene)
			else:
				GameManager.is_afterlife = true
				change_scene(SceneTransition.title_scene)
		
		if _time_elapsed > action_delay_time and not _is_hint_shown:
			_is_hint_shown = true
			_end_hint.visible = true
	else:
		if (_time_elapsed > delay_time):
			# Roll credits
			_container.rect_position.y -= speed * delta
			if (_end_credits.rect_global_position.y <= 0):
				_end_credits.rect_global_position.y = 0
				_is_at_end_credits = true
				_time_elapsed = 0

func _exit_tree():
	AudioManager.stop_music()

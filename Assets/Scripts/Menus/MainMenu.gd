extends Node2D

onready var title_text = $MarginContainer/VBoxContainer/Title
onready var start_button = $MarginContainer/VBoxContainer/VBoxContainer/Start/StartButton

func _ready():
	title_text.text = GameManager.get_title()
	GameManager.reset_progress()
	start_button.grab_focus()
	
	if GameManager.is_afterlife:
		AudioManager.attach_sound(AudioManager.SoundType.TRUE_MENU)
		AudioManager.play_sound(AudioManager.SoundType.TRUE_MENU)
	else:
		AudioManager.attach_sound(AudioManager.SoundType.CLASSIC_MENU)
		AudioManager.play_sound(AudioManager.SoundType.CLASSIC_MENU)
	
	AudioManager.attach_sound(AudioManager.SoundType.SFX1)
	AudioManager.attach_sound(AudioManager.SoundType.SFX2)

func _process(_delta):
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
		AudioManager.play_sound(AudioManager.SoundType.SFX1)
	
	elif Input.is_action_just_pressed("action"):
		AudioManager.play_sound(AudioManager.SoundType.SFX2)

func _start_game():
	if (GameManager.is_afterlife):
		SceneTransition.change_scene(SceneTransition.main_game_scene)
	else:
		SceneTransition.change_scene(SceneTransition.classic_game_scene)

func _go_to_credits():
	SceneTransition.change_scene(SceneTransition.credits_scene)
	
func _quit_game():
	get_tree().quit()
	
func _exit_tree():
	if GameManager.is_afterlife:
		AudioManager.remove_sound(AudioManager.SoundType.TRUE_MENU)
	else:
		AudioManager.remove_sound(AudioManager.SoundType.CLASSIC_MENU)

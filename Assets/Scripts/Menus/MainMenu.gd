extends Node2D

@onready var title_text = $MarginContainer/VBoxContainer/Title
@onready var start_button = $MarginContainer/VBoxContainer/VBoxContainer/Start/StartButton

func _ready():
	title_text.text = GameManager.get_title()
	GameManager.reset_progress()
	start_button.grab_focus()
	
	var sound_type = AudioManager.MusicType.TRUE_MENU if GameManager.is_afterlife else AudioManager.MusicType.CLASSIC_MENU
	AudioManager.play_music(sound_type)

func _process(_delta):
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
		AudioManager.play_sfx(AudioManager.SFXType.SFX1)
	
	elif Input.is_action_just_pressed("action"):
		AudioManager.play_sfx(AudioManager.SFXType.SFX2)

func _start_game():
	if (GameManager.is_afterlife):
		SceneTransition.change_scene_to_file(SceneTransition.main_game_scene)
	else:
		SceneTransition.change_scene_to_file(SceneTransition.classic_game_scene)

func _go_to_credits():
	SceneTransition.change_scene_to_file(SceneTransition.credits_scene)
	
func _quit_game():
	get_tree().quit()

func _exit_tree():
	AudioManager.stop_music()

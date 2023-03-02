extends Node2D

func _ready():
	GameManager.is_level_done = false
	PlayerData.reset_health()
	if GameManager.is_afterlife:
		AudioManager.play_music(AudioManager.MusicType.GAME)
	
func _on_level_done():
	GameManager.is_balls_running = false
	GameManager.is_level_done = true
	
func _exit_tree():
	if GameManager.is_afterlife:
		AudioManager.stop_music()

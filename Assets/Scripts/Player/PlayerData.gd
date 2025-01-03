extends Node

const initial_classic_player_health = 3
const initial_afterlife_player_health = 1
var player = null
var player_width = 96 # Player width in pixels
var player_health = -1: get = get_health

func get_health():
	if player_health == -1:
		reset_health()
	return player_health

func reset_health():
	if GameManager.is_afterlife:
		player_health = initial_afterlife_player_health
	else:
		player_health = initial_classic_player_health
	
func lose_health():
	player_health -= 1

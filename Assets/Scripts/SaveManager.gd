extends Node

const save_file = "res://save_file.save"
var save_data = {}

func _ready():
	load_data()

func save_data():
	var file = File.new()
	file.open(save_file, File.WRITE)
	file.store_var(save_data)
	file.close()

func load_data():
	var file = File.new()
	if not file.file_exists(save_file):
		save_data = {
			"is_afterlife": false,
			"current_paddle": "res://Assets/Prefabs/Paddle/ClassicPaddle.tscn",
			"current_ball": "res://Assets/Prefabs/Ball/ClassicBall.tscn",
			"owned_paddles": ["res://Assets/Prefabs/Paddle/ClassicPaddle.tscn"],
			"owned_balls": ["res://Assets/Prefabs/Ball/ClassicBall.tscn"]
		}
		save_data()
	file.open(save_file, File.READ)
	save_data = file.get_var()
	file.close()

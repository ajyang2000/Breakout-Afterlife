extends Node

const save_file = "res://save_file.save"

var data = {}

func _ready():
	load_data()

func save_data():
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	file.store_var(data)
	file.close()
	

func load_data():
	var file = FileAccess.open(save_file, FileAccess.READ)
	if not file == null:
		data = {
			"is_afterlife": false,
			#"current_paddle": "res://Assets/Prefabs/Paddle/ClassicPaddle.tscn",
			#"current_ball": "res://Assets/Prefabs/Ball/ClassicBall.tscn",
			"owned_paddles": ["res://Assets/Prefabs/Paddle/ClassicPaddle.tscn"],
			"owned_balls": ["res://Assets/Prefabs/Ball/ClassicBall.tscn"]
		}
		save_data()
	data = file.get_var()
	file.close()

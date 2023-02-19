extends Resource

const red_ball = "res://Assets/Prefabs/Ball/RedBall.tscn"
const blue_ball = "res://Assets/Prefabs/Ball/BlueBall.tscn"
const dark_ball = "res://Assets/Prefabs/Ball/DarkBall.tscn"
const green_ball = "res://Assets/Prefabs/Ball/GreenBall.tscn"
const light_ball = "res://Assets/Prefabs/Ball/LightBall.tscn"
const neon_ball = "res://Assets/Prefabs/Ball/NeonBall.tscn"
const classic_ball = "res://Assets/Prefabs/Ball/ClassicBall.tscn"

const red_paddle = "res://Assets/Prefabs/Paddle/RedPaddle.tscn"
const blue_paddle = "res://Assets/Prefabs/Paddle/BluePaddle.tscn"
const dark_paddle = "res://Assets/Prefabs/Paddle/DarkPaddle.tscn"
const green_paddle = "res://Assets/Prefabs/Paddle/GreenPaddle.tscn"
const light_paddle = "res://Assets/Prefabs/Paddle/LightPaddle.tscn"
const neon_paddle = "res://Assets/Prefabs/Paddle/NeonPaddle.tscn"
const classic_paddle = "res://Assets/Prefabs/Paddle/ClassicPaddle.tscn"

var save_data = SaveManager.data

func get_current_paddle() -> String:
	return save_data.current_paddle

func get_current_ball() -> String:
	return save_data.current_ball

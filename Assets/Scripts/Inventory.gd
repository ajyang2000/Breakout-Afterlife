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

var available_rewards = [
		blue_paddle, 
		dark_paddle, 
		green_paddle,
		light_paddle, 
		neon_paddle, 
		red_paddle, 
		blue_ball,
		dark_ball,
		green_ball,
		light_ball,
		neon_ball, 
		red_ball,
	]

func get_current_paddle() -> String:
	if save_data == null:
		return red_paddle
		
	SaveManager.load_data()
	randomize()
	var index = randi() % save_data.owned_paddles.size()
	return save_data.owned_paddles[index]

func get_current_ball() -> String:
	if save_data == null:
		return red_ball
	
	SaveManager.load_data()
	randomize()
	var index = randi() % save_data.owned_balls.size()
	return save_data.owned_balls[index]
	
func get_random_reward():
	if save_data == null:
		return null
	
	SaveManager.load_data()
	# Awful solution but order depends on frame
	var indices = []
	for i in range(available_rewards.size()):
		indices.append(i)
	
	for collected_paddle in save_data.owned_paddles:
		var index = available_rewards.find(collected_paddle)
		if index != -1:
			indices.erase(index)
	for collected_ball in save_data.owned_balls:
		var index = available_rewards.find(collected_ball)
		if index != -1:
			indices.erase(index)
			
	if indices.size() == 0:
		return 12
	
	randomize()
	var index = randi() % indices.size()
	var reward_index = indices[index]
	var item = available_rewards[reward_index]
	if (index < 6):
		save_data.owned_paddles.append(item)
	else:
		save_data.owned_balls.append(item)
	
	SaveManager.save_data()
		
	return index

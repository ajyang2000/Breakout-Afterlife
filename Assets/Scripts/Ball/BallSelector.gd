extends Node2D

const red_ball = "res://Assets/Prefabs/Ball/RedBall.tscn"
const blue_ball = "res://Assets/Prefabs/Ball/BlueBall.tscn"
const dark_ball = "res://Assets/Prefabs/Ball/DarkBall.tscn"
const green_ball = "res://Assets/Prefabs/Ball/GreenBall.tscn"
const light_ball = "res://Assets/Prefabs/Ball/LightBall.tscn"
const neon_ball = "res://Assets/Prefabs/Ball/NeonBall.tscn"
const classic_ball = "res://Assets/Prefabs/Ball/ClassicBall.tscn"

signal brick_hit(brick)
signal ball_lost
signal game_over

var ball

func _ready():
	if (GameManager.is_afterlife):
		ball = load(red_ball).instance()
	else:
		ball = load(classic_ball).instance()

	add_child(ball)
	ball.connect("brick_hit", self, "_on_brick_hit")
	ball.connect("ball_lost", self, "_on_ball_lost")
	ball.connect("game_over", self, "_on_game_over")
		
func _on_brick_hit(brick):
	emit_signal("brick_hit", brick)

func _on_ball_lost():
	emit_signal("ball_lost")

func _on_game_over():
	emit_signal("game_over")


func _on_level_done():
	if (ball != null):
		ball.on_level_done()


func _on_action_pressed():
	if (ball != null):
		ball.on_action_pressed()

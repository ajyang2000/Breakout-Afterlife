extends Node2D

const red_paddle = "res://Assets/Prefabs/Paddle/RedPaddle.tscn"
const blue_paddle = "res://Assets/Prefabs/Paddle/BluePaddle.tscn"
const dark_paddle = "res://Assets/Prefabs/Paddle/DarkPaddle.tscn"
const green_paddle = "res://Assets/Prefabs/Paddle/GreenPaddle.tscn"
const light_paddle = "res://Assets/Prefabs/Paddle/LightPaddle.tscn"
const neon_paddle = "res://Assets/Prefabs/Paddle/NeonPaddle.tscn"
const classic_paddle = "res://Assets/Prefabs/Paddle/ClassicPaddle.tscn"

signal control_action
signal control_back
signal control_start

func _ready():
	var paddle
	if (GameManager.is_afterlife):
		paddle = load(red_paddle).instance()
	else:
		paddle = load(classic_paddle).instance()

	add_child(paddle)

func _physics_process(delta):
	if Input.is_action_just_pressed("action"):
		emit_signal("control_action")
	
	if Input.is_action_just_pressed("start"):
		emit_signal("control_start")

extends Node2D

const inventory = preload("res://Assets/Configs/Inventory.tres")

signal control_action
signal control_back
signal control_start

func _ready():
	var paddle
	if (GameManager.is_afterlife):
		paddle = load(inventory.get_current_paddle()).instantiate()
	else:
		paddle = load(inventory.classic_paddle).instantiate()

	add_child(paddle)

func _physics_process(delta):
	if Input.is_action_just_pressed("action"):
		emit_signal("control_action")
	
	if Input.is_action_just_pressed("start"):
		emit_signal("control_start")

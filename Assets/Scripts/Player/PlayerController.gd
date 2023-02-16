extends Node

signal control_move_left
signal control_move_right
signal control_action
signal control_back
signal control_start

func _physics_process(delta):
	if Input.is_action_pressed("move_left"):
		emit_signal("control_move_left")
	elif Input.is_action_pressed("move_right"):
		emit_signal("control_move_right")
	
	if Input.is_action_just_pressed("action"):
		emit_signal("control_action")

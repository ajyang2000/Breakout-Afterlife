extends Control

const health_frame = "res://Assets/Frames/Environment/Health.tres"
@onready var health_container = $HealthContainer
@onready var health_icon = $HealthContainer/Health

func _ready():
	var lives = PlayerData.player_health
	var health_icon_frame = load(health_frame)
	for i in lives:
		var current_icon = health_icon if i == 0 else health_icon.duplicate()
		if i != 0:
			health_container.add_child(current_icon)
		current_icon.position.x = health_icon.position.x + 32 * i
		current_icon.position.y = health_icon.position.y 
		current_icon.frames = health_icon_frame
		current_icon.frame = 2 if GameManager.is_afterlife else 0

func _on_ball_lost():
	var lost_life = health_container.get_child(health_container.get_child_count() - 1)
	if lost_life != null:
		lost_life.queue_free()


func _on_shield_hit(percentage):
	var life = health_container.get_child(health_container.get_child_count() - 1)
	if (life != null):
		if percentage <= 0:
			life.frame = 0
		elif percentage < 0.5:
			life.frame = 1

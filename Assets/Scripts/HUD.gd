extends Control

const health_no_shield = "res://Assets/hp_exposed.png"
onready var health_container = $HealthContainer
onready var health_icon = $HealthContainer/Health

func _ready():
	var lives = PlayerData.player_health
	var health_icon_prefab = load(health_no_shield)
	for i in lives:
		var current_icon = health_icon if i == 0 else health_icon.duplicate()
		if i != 0:
			health_container.add_child(current_icon)
		current_icon.position.x = health_icon.position.x + 32 * i
		current_icon.position.y = health_icon.position.y 
		current_icon.texture = health_icon_prefab

func _on_ball_lost():
	var lost_life = health_container.get_child(health_container.get_child_count() - 1)
	lost_life.queue_free()

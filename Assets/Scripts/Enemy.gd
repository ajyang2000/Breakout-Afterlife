extends Node2D

const _level_config = preload("res://Assets/Scripts/Configs/AfterlifeDynamicLevelConfigs.gd")

@onready var ball = $EnemyBall
@onready var shield = $EnemyShield
@onready var paddle = $EnemyPaddle

func _ready():
	var data = _level_config.boss_settings[String(GameManager.boss_defeated_count + 1)]
	ball.power = data[0]
	ball.speed = data[2]
	paddle.speed = data[1]
	shield.initial_hit_points = data[3]
	shield.hit_points = data[3]

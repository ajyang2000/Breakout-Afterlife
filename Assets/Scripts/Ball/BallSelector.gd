extends Node2D

const inventory = preload("res://Assets/Configs/Inventory.tres")

signal brick_hit(brick)
signal ball_lost
signal game_over
signal boss_defeated

var ball

func _ready():
	if (GameManager.is_afterlife):
		ball = load(inventory.get_current_ball()).instantiate()
	else:
		ball = load(inventory.classic_ball).instantiate()

	add_child(ball)
	ball.connect("brick_hit", Callable(self, "_on_brick_hit"))
	ball.connect("ball_lost", Callable(self, "_on_ball_lost"))
	ball.connect("game_over", Callable(self, "_on_game_over"))
	ball.connect("boss_defeated", Callable(self, "_on_boss_defeated"))
		
func _on_brick_hit(brick, power):
	emit_signal("brick_hit", brick, power)

func _on_ball_lost():
	emit_signal("ball_lost")

func _on_game_over():
	emit_signal("game_over")

func _on_boss_defeated():
	emit_signal("boss_defeated")

func _on_action_pressed():
	if (ball != null):
		ball.on_action_pressed()

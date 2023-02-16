extends Node

const _brick = preload("res://Assets/Prefabs/Environment/Brick.tscn")

export var rows = 3
export var columns = 10
export(int, 1, 5) var difficulty = 3

var _bricks = []

signal level_done

func _ready():
	var empty_brick_range = 0.6 - (difficulty / 10.0)
	
	for column in range(columns):
		for row in range(rows * difficulty):
			var random = rand_range(0, 1)
			if random < empty_brick_range:
				pass
			elif random < 0.7:
				var brick = _brick.instance()
				_init_brick(brick, brick.BrickType.WHITE, row, column, true)
			elif random < 0.85:
				var brick = _brick.instance()
				_init_brick(brick, brick.BrickType.PURPLE, row, column, true)
			elif random < 0.95:
				var brick = _brick.instance()
				_init_brick(brick, brick.BrickType.ORANGE, row, column, true)
			else:
				var brick = _brick.instance()
				_init_brick(brick, brick.BrickType.BLUE, row, column, true)

func _init_brick(brick, brickType, row, column, is_destructible):
	brick.set_type(brickType)
	brick.set_is_destructible(is_destructible)
	
	add_child(brick)
	brick.position.x = column * GameConstants.brick_width
	brick.position.y = row * GameConstants.brick_height
	
	if (is_destructible):
		_bricks.append(brick)

func _on_brick_hit(brick):
	var brick_index = _bricks.find(brick)
	var is_brick_found = brick_index != -1
	if (brick.is_alive_after_hit() and is_brick_found):
		_bricks.remove(brick_index)
	
	if (_bricks.size() == 0):
		emit_signal("level_done")
		


func _on_Ball_game_over():
	pass # Replace with function body.

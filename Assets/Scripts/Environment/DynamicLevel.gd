extends Node

const _brick = preload("res://Assets/Prefabs/Environment/Bricks/Brick.tscn")
const _level_config = preload("res://Assets/Scripts/Configs/AfterlifeDynamicLevelConfigs.gd")
const offset = Vector2(156, 24)

export var max_columns = 13

var _bricks = []

signal level_done

func _ready():
	var data = _level_config.level_difficulty[String(GameManager.level)]
	var empty_brick_range = data[_level_config.empty_spawn_chance]
	var columns = data[_level_config.column_index]
	var rows = data[_level_config.row_index]
	
	for column in range(columns):
		for row in range(rows):
			var random = rand_range(0, 1)
			if random < empty_brick_range:
				pass
			elif random < 0.7:
				var brick = _brick.instance()
				_init_brick(brick, brick.BrickType.NORMAL, row, column, true, columns)
			elif random < 0.85:
				var brick = _brick.instance()
				_init_brick(brick, brick.BrickType.BONUS, row, column, true, columns)
			elif random < 0.95:
				var brick = _brick.instance()
				_init_brick(brick, brick.BrickType.SPECIAL, row, column, true, columns)
			else:
				var brick = _brick.instance()
				_init_brick(brick, brick.BrickType.STRONG, row, column, true, columns)

func _physics_process(delta):
	if Input.is_action_just_pressed("debug_next_level"):
		emit_signal("level_done")

func _init_brick(brick, brickType, row, column, is_destructible, max_spawned_column):
	brick.set_type(brickType)
	brick.set_is_destructible(is_destructible)
	
	add_child(brick)
	brick.position.x = column * GameManager.brick_width
	brick.position.y = row * GameManager.brick_height
	brick.position += offset 
	brick.position.x += int((max_columns - max_spawned_column) / 2.0) * GameManager.brick_width
	
	if (is_destructible):
		_bricks.append(brick)

func _on_brick_hit(brick):
	var brick_index = _bricks.find(brick)
	var is_brick_found = brick_index != -1
	if (brick.is_alive_after_hit() and is_brick_found):
		_bricks.remove(brick_index)
	
	if (_bricks.size() == 0):
		emit_signal("level_done")

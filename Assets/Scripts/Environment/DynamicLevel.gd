extends Node

const _brick = preload("res://Assets/Prefabs/Environment/Bricks/Brick.tscn")
const _level_config = preload("res://Assets/Scripts/Configs/AfterlifeDynamicLevelConfigs.gd")

export var offset = Vector2(128, 24)
export var max_columns = 13
export var is_boss_level = false

var _bricks = []

signal level_done

func _ready():
	var data = _level_config.level_difficulty[String(GameManager.level)]
	var empty_brick_range = data[_level_config.empty_spawn_chance]
	var columns = data[_level_config.column_index]
	var rows = data[_level_config.row_index]
	PlayerData.reset_health()
	
	columns = 14
	for column in range(columns):
		for row in range(rows):
			var random = rand_range(0, 1)
			if random < empty_brick_range:
				pass
			elif random < (empty_brick_range + 0.03):
				var brick = _brick.instance()
				_init_brick(brick, brick.BrickType.SPECIAL, row, column, true, columns, rows)
			elif random < (empty_brick_range + 0.04):
				var brick = _brick.instance()
				_init_brick(brick, brick.BrickType.BONUS, row, column, true, columns, rows)
			elif random < (empty_brick_range + 0.04 + GameManager.level / 100.0):
				var brick = _brick.instance()
				_init_brick(brick, brick.BrickType.STRONG, row, column, true, columns, rows)
			else:
				var brick = _brick.instance()
				_init_brick(brick, brick.BrickType.NORMAL, row, column, true, columns, rows)

func _physics_process(delta):
	if Input.is_action_just_pressed("debug_next_level"):
		emit_signal("level_done")

func _init_brick(brick, brickType, row, column, is_destructible, max_spawned_column, max_spawned_row):
	var hp = 1
	if (GameManager.is_afterlife):
		var tier = int((GameManager.level - 1) / 3)
		hp = _level_config.brick_hp_tiers[tier]
	brick.init(brickType, hp)
	brick.set_is_destructible(is_destructible)
	
	add_child(brick)
	brick.position.x = column * GameManager.brick_width
	brick.position.y = row * GameManager.brick_height
	brick.position += offset
	brick.position.x += floor((max_columns - max_spawned_column) / 2.0) * GameManager.brick_width
	if (is_boss_level):
		brick.position.y -= floor(max_spawned_row / 2.0) * GameManager.brick_height
	
	if (is_destructible):
		_bricks.append(brick)

func _on_brick_hit(brick, power):
	var brick_index = _bricks.find(brick)
	var is_brick_found = brick_index != -1
	if (!brick.is_alive_after_hit(power) and is_brick_found):
		_bricks.remove(brick_index)
	if (_bricks.size() == 0):
		emit_signal("level_done")

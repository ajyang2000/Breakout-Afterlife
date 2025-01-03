extends Node2D

var _levels = []
var _loaded_level

signal level_done

func _ready():
	_load_levels()
	var index = clamp(GameManager.level - 1, 0, _levels.size() - 1)
	_loaded_level = load(_levels[index]).instantiate()
	add_child(_loaded_level)

func _physics_process(delta):
	if Input.is_action_just_pressed("debug_next_level"):
		emit_signal("level_done")

func _on_brick_hit(_brick):
	if (_loaded_level.get_child_count() <= 1):
		emit_signal("level_done")

func _load_levels():
	# intiialize level list.
	pass
	

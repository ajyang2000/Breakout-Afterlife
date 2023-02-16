extends StaticBody2D

enum BrickType{WHITE, PURPLE,ORANGE, BLUE}

onready var _sprite = $Sprite

var _hit_points
var _brickType = BrickType.WHITE
var _is_destructible = true

func _ready():
	set_meta("Brick", true)
	_load_brick(_brickType)

func set_type(value):
	_brickType = value

func set_is_destructible(value):
	_is_destructible = value

func is_alive_after_hit():
	return _hit_points > 1

func hit():
	if (not _is_destructible):
		return
	_hit_points -= 1
	
	if (_hit_points <= 0):
		queue_free()

func _load_brick(brick_type):
	match brick_type:
		BrickType.WHITE:
			_sprite.region_rect = Rect2(320, 0, 160, 80)
			_hit_points = 1
		BrickType.PURPLE:
			_sprite.region_rect = Rect2(480, 0, 160, 80)
			_hit_points = 1
		BrickType.ORANGE:
			_sprite.region_rect = Rect2(320, 80, 160, 80)
			_hit_points = 1
		BrickType.BLUE:
			_sprite.region_rect = Rect2(480, 80, 160, 80)
			_hit_points = 1

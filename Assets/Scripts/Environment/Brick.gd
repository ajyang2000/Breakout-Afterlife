extends StaticBody2D

var _blue_frames = preload("res://Assets/Frames/Environment/Bricks/BlueBrickFrames.tres")
var _green_frames = preload("res://Assets/Frames/Environment/Bricks/GreenBrickFrames.tres")
var _dark_frames = preload("res://Assets/Frames/Environment/Bricks/DarkBrickFrames.tres")

enum BrickType{ 
	BLUE = 0, 
	GREEN = 1, 
	DARK = 2
}

onready var _animated_sprite = $AnimatedSprite

var _hit_points
var _brickType = BrickType.BLUE
var _is_destructible = true

func _ready():
	set_meta("Brick", true)
	
	_load_brick(_brickType)
	_hit_points = _animated_sprite.frames.get_frame_count("default")

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
	
	if _animated_sprite.frame < _animated_sprite.frames.get_frame_count("default"):
		_animated_sprite.frame += 1
	
	if (_hit_points <= 0):
		queue_free()

func _load_brick(brick_type):
	match brick_type:
		BrickType.BLUE:
			_animated_sprite.frames = _blue_frames
		BrickType.GREEN:
			_animated_sprite.frames = _green_frames
		BrickType.DARK:
			_animated_sprite.frames = _dark_frames

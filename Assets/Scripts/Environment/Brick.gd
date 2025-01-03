extends StaticBody2D

const _brick_data = preload("res://Assets/Resources/BrickData.tres")

@onready var _sprite: Sprite2D = $Sprite2D

var _hit_points = 1
@export var _brick_type: int = BrickData.BrickType.CLASSIC
var _is_destructible = true
var _brick_dict = {}

func _ready():
	set_meta("Brick", true)
	_sprite.texture = _brick_data.get_brick_texture(_brick_type)

func init(brick_type, hit_points):
	_brick_type = brick_type
	_hit_points = _brick_data.get_brick_health(brick_type, hit_points)
	_is_destructible = _brick_data.get_brick_is_destructible(brick_type)

func set_is_destructible(value):
	_is_destructible = value

func set_hit_points(value):
	_hit_points = value

func is_alive_after_hit(power):
	return _hit_points - power > 0

func hit(power: int = 1):
	if (not _is_destructible):
		return
	_hit_points -= power
	
	if (_hit_points <= 0):
		queue_free()
		AudioManager.play_sfx(AudioManager.SFXType.SFX8)
	else:
		AudioManager.play_sfx(AudioManager.SFXType.SFX7)

extends StaticBody2D

const audio_manager = preload("res://Assets/Prefabs/Audio/AudioManager.tres")
const _brick_normal = "res://Assets/Sprites/brick_normal.png"
const _brick_bonus = "res://Assets/Sprites/brick_bonus.png"
const _brick_special = "res://Assets/Sprites/brick_special.png"
const _brick_strong = "res://Assets/Sprites/brick_strong.png"
	
enum BrickType{
	NORMAL, 
	BONUS,
	SPECIAL, 
	STRONG
}

onready var _sprite = $Sprite

var _hit_points
var _brickType = BrickType.NORMAL
var _is_destructible = true

var _brick_dict = {}

func _ready():
	set_meta("Brick", true)
	_load_brick(_brickType)
	
	audio_manager.instance.attach_sound(audio_manager.SoundType.SFX7)
	audio_manager.instance.attach_sound(audio_manager.SoundType.SFX8)

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
		audio_manager.instance.play_sound(audio_manager.SoundType.SFX8)
	else:
		audio_manager.instance.play_sound(audio_manager.SoundType.SFX7)

func _load_brick(brick_type, hit_points: int = 1):
	match brick_type:
		BrickType.NORMAL:
			_sprite.texture = load(_brick_normal)
		BrickType.STRONG:
			_sprite.texture = load(_brick_strong)
		BrickType.SPECIAL:
			_sprite.texture = load(_brick_special)
		BrickType.BONUS:
			_sprite.texture = load(_brick_bonus)
	_hit_points = hit_points

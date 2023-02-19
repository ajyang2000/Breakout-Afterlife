extends StaticBody2D

const _brick_normal = "res://Assets/Sprites/brick_normal.png"
const _brick_bonus = "res://Assets/Sprites/brick_bonus.png"
const _brick_special = "res://Assets/Sprites/brick_special.png"
const _brick_strong = "res://Assets/Sprites/brick_strong.png"
const _brick_classic = "res://Assets/Sprites/classic_brick.png"
	
enum BrickType{
	CLASSIC
	NORMAL, 
	BONUS,
	SPECIAL, 
	STRONG
}

onready var _sprite = $Sprite

var _hit_points
export var _brickType = BrickType.CLASSIC
var _is_destructible = true
var _brick_dict = {}

func _ready():
	set_meta("Brick", true)
	_load_brick(_brickType)
	
	AudioManager.attach_sound(AudioManager.SoundType.SFX7)
	AudioManager.attach_sound(AudioManager.SoundType.SFX8)

func init(brick_type, hit_points):
	_brickType = brick_type
	match brick_type:
		BrickType.CLASSIC:
			_hit_points = 1
		BrickType.NORMAL:
			_hit_points = hit_points
		BrickType.STRONG:
			_hit_points = hit_points
			_is_destructible = false
		BrickType.SPECIAL:
			_hit_points = hit_points + 2
		BrickType.BONUS:
			_hit_points = hit_points + 4

func set_is_destructible(value):
	_is_destructible = value

func set_hit_points(value):
	_hit_points = value

func is_alive_after_hit(power):
	return _hit_points - power > 0

func hit(power: int):
	if (not _is_destructible):
		return
	_hit_points -= power
	
	if (_hit_points <= 0):
		queue_free()
		AudioManager.play_sound(AudioManager.SoundType.SFX8)
	else:
		AudioManager.play_sound(AudioManager.SoundType.SFX7)

func _load_brick(brick_type):
	match brick_type:
		BrickType.CLASSIC:
			_sprite.texture = load(_brick_classic)
		BrickType.NORMAL:
			_sprite.texture = load(_brick_normal)
		BrickType.STRONG:
			_sprite.texture = load(_brick_strong)
		BrickType.SPECIAL:
			_sprite.texture = load(_brick_special)
		BrickType.BONUS:
			_sprite.texture = load(_brick_bonus)

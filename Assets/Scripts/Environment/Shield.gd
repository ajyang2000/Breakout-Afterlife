extends StaticBody2D

const DESTROY_SFX_DELAY_TIME = 0.5

onready var _visuals = $VisualContainer
onready var _collider = $CollisionPolygon

var _initial_hit_points = 3
var _hit_points = 3

signal shield_hit

func _ready():
	_hit_points = _initial_hit_points
	set_meta("Shield", true)
	AudioManager.attach_sound(AudioManager.SoundType.SFX3)
	AudioManager.attach_sound(AudioManager.SoundType.SFX4)
	
	for child in _visuals.get_children():
		child.frame = 0

func hit(power: int):
	_hit_points -= power
	
	AudioManager.play_sound(AudioManager.SoundType.SFX3)
	for child in _visuals.get_children():
		child.frame = 1
		child.play()
	
	emit_signal("shield_hit", _hit_points / (_initial_hit_points * 1.0))
	
	if (_hit_points <= 0):
		var t = Timer.new()
		t.set_wait_time(DESTROY_SFX_DELAY_TIME)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		AudioManager.play_sound(AudioManager.SoundType.SFX4)
		t.queue_free()
		
		visible = false
		_collider.disabled = true

func _on_ball_lost():
	if PlayerData.player_health <= 0:
		queue_free()
	else:
		visible = true
		_collider.disabled = false
		_hit_points = _initial_hit_points

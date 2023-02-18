extends StaticBody2D

onready var _visuals = $VisualContainer
onready var _collider = $CollisionPolygon

var _hit_points = 3

func _ready():
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
	
	print(_hit_points)
	if (_hit_points <= 0):
		var t = Timer.new()
		t.set_wait_time(0.5)
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
		_hit_points = 3

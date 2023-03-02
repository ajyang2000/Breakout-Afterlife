extends StaticBody2D

const DESTROY_SFX_DELAY_TIME = 0.5

onready var _visuals = $VisualContainer
onready var _collider = $CollisionPolygon

var initial_hit_points: int = 3
var hit_points: int = 3

signal shield_hit

func _ready():
	hit_points = initial_hit_points
	set_meta("Shield", true)
	
	for child in _visuals.get_children():
		child.frame = 0

func hit(power: int):
	hit_points -= power
	
	AudioManager.play_sfx(AudioManager.SFXType.SFX3)
	for child in _visuals.get_children():
		child.frame = 1
		child.play()
	
	emit_signal("shield_hit", hit_points / (initial_hit_points * 1.0))
	
	if (hit_points <= 0):
		var t = Timer.new()
		t.set_wait_time(DESTROY_SFX_DELAY_TIME)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		AudioManager.play_sfx(AudioManager.SFXType.SFX4)
		t.queue_free()
		
		visible = false
		_collider.disabled = true

func _on_ball_lost():
	if PlayerData.player_health <= 0:
		queue_free()
	else:
		visible = true
		_collider.disabled = false
		hit_points = initial_hit_points

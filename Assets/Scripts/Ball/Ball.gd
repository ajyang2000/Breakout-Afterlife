extends KinematicBody2D

const speed_multiplier = 500;

export var power: int = 1
export var speed: int = 1

onready var _visibility_notifier = $VisibilityNotifier;

var _direction: Vector2 = Vector2(0, 1);
var _initial_position: Vector2
var _initial_direction: Vector2 = Vector2(0, 1)

signal brick_hit(brick)
signal ball_lost
signal game_over
signal boss_defeated

func _ready():
	_initial_position = self.global_position
	AudioManager.attach_sound(AudioManager.SoundType.SFX0)
	
func _physics_process(delta):
	_check_ball_lost();
	
	if not GameManager.is_balls_running:
		return
	
	_direction = _direction.normalized()
	var velocity = speed * _direction * delta * speed_multiplier;
	var collision = move_and_collide(velocity);
	
	if (collision != null):
		if PlayerData.player == collision.collider:
			_direction = _direction.bounce(collision.normal)
			_direction.x = get_x_bounce_direction(collision)
		elif GameManager.enemy_paddle == collision.collider:
			_direction = _direction.bounce(collision.normal)
			_direction.x = -get_x_bounce_direction(collision)
		else:
			var hit_position = collision.position - collision.collider.global_position
			var normal = _fix_normal(collision.normal, hit_position)
			_direction = _direction.bounce(normal)
			
			if collision.collider.has_meta("Brick"):
				var brick = collision.collider
				emit_signal("brick_hit", brick, power)
				brick.hit(power)
			elif collision.collider.has_meta("Shield"):
				var shield = collision.collider
				shield.hit(power)

func _check_ball_lost():
	if not _visibility_notifier.is_on_screen() and GameManager.is_balls_running:
		var is_boss_defeated = false
		if (self.global_position.y < 0):
			# boss lost 
			is_boss_defeated = true
			emit_signal("boss_defeated")
			GameManager.is_balls_running = false
		else:
			emit_signal("ball_lost")
			PlayerData.lose_health()
		
		if (PlayerData.player_health == 0 and !is_boss_defeated):
			emit_signal("game_over")
		else:
			self.global_position = _initial_position
			_direction = _initial_direction
		GameManager.is_balls_running = false

func get_x_bounce_direction(collision: KinematicCollision2D):
	var relative_x = collision.position.x - PlayerData.player.global_position.x
	var percentage = relative_x / PlayerData.player_width
	return (percentage - 0.5) * 2 # should be in range [-1, 1]

func _fix_normal(normal, hit_position):
	if (normal.x == 1 or normal.x == -1 or normal.y == 1 or normal.y == -1):
		return normal
	if (hit_position.x < 2 and hit_position.y < 2):
		# Upper left corner
		normal = Vector2(-0.5, -0.5)
	elif (hit_position.x > GameManager.brick_width - 2 and hit_position.y < 2):
		# Upper right corner
		normal = Vector2(0.5, -0.5)
	elif (hit_position.x > GameManager.brick_width - 2 and hit_position.y > GameManager.brick_height - 2):
		# Lower right corner
		normal = Vector2(0.5, 0.5)
	elif (hit_position.x < 2 and hit_position.y > GameManager.brick_height - 2):
		# Lower left corner
		normal = Vector2(-0.5, 0.5)
	
	return normal.normalized()

func on_action_pressed():
	if not GameManager.is_level_done and not GameManager.is_balls_running:
		AudioManager.play_sound(AudioManager.SoundType.SFX0)
		GameManager.is_balls_running = true;

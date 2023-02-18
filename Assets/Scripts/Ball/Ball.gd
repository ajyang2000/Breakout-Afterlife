extends KinematicBody2D

const speed_multiplier = 500;

export var power = 1
export var speed = 1

onready var _visibility_notifier = $VisibilityNotifier;

var _direction = Vector2(0, 1);
var _is_running = false;
var _is_game_over = false;
var _initial_position: Vector2

signal brick_hit(brick)
signal brick_lost
signal game_over

func _ready():
	_initial_position = self.position
	
func _physics_process(delta):
	_check_ball_lost();
	
	if not _is_running:
		return
	
	_direction = _direction.normalized()
	var velocity = speed * _direction * delta * speed_multiplier;
	var collision = move_and_collide(velocity);
	
	if (collision != null):
		if PlayerData.player == collision.collider:
			_direction = _direction.bounce(collision.normal)
			_direction.x = get_x_bounce_direction(collision)
		else:
			var hit_position = collision.position - collision.collider.global_position
			var normal = _fix_normal(collision.normal, hit_position)
			_direction = _direction.bounce(collision.normal)
			
			if collision.collider.has_meta("Brick"):
				var brick = collision.collider
				emit_signal("brick_hit", brick)
				brick.hit()

func _check_ball_lost():
	if not _visibility_notifier.is_on_screen():
		if _is_running:
			emit_signal("brick_lost")
			PlayerData.player_health -= 1
			
			if (PlayerData.player_health == 0):
				emit_signal("game_over")
				_is_game_over = true
			else:
				self.position = _initial_position
				_direction = Vector2(0, 1)
			_is_running = false

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

func _on_action_pressed():
	if not _is_game_over:
		_is_running = true;

func _on_level_done():
	_is_running = true
	_is_game_over = true

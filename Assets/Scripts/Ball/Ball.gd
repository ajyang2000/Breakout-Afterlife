extends KinematicBody2D

const player_container = preload("res://Assets/Prefabs/Player/PlayerContainer.tres")
const _main_scene = "res://Scenes/Main.tscn";

export var speed = 500;

onready var _visibility_notifier = $VisibilityNotifier;

var _direction = Vector2(0.5, 1);
var _is_running = false;

signal brick_hit(brick)
signal game_over

func _physics_process(delta):
	if not _is_running:
		return
	
	_check_game_over();
	
	_direction = _direction.normalized()
	var velocity = speed * _direction * delta;
	var collision = move_and_collide(velocity);
	
	if (collision != null):
		if player_container.player == collision.collider:
			_direction = _direction.bounce(collision.normal)
			_direction.x = get_x_bounce_direction(collision)
		else:
			var hit_position = collision.position - collision.collider.global_position
			var normal = _fix_normal(collision.normal, hit_position)
			_direction = _direction.bounce(normal)
			
			if collision.collider.has_meta("Brick"):
				var brick = collision.collider
				emit_signal("brick_hit", brick)
				brick.hit()

func _check_game_over():
	if not _visibility_notifier.is_on_screen():
		emit_signal("game_over")

func get_x_bounce_direction(collision: KinematicCollision2D):
	var relative_x = collision.position.x - player_container.player.global_position.x
	var percentage = relative_x / player_container.player_width
	return percentage - 0.5 * 2 # should be in range [-1, 1]

func _fix_normal(normal, hit_position):
	if (normal.x == 1 or normal.x == -1 or normal.y == 1 or normal.y == -1):
		return normal
	## TODO: Remove magic numbers if have time
	if (hit_position.x < 2 and hit_position.y < 2):
		# Upper left corner
		normal = Vector2(-0.5, -0.5)
	elif (hit_position.x > GameUtility.brick_width - 2 and hit_position.y < 2):
		# Upper right corner
		normal = Vector2(0.5, -0.5)
	elif (hit_position.x > GameUtility.brick_width - 2 and hit_position.y > GameUtility.brick_height - 2):
		# Lower right corner
		normal = Vector2(0.5, 0.5)
	elif (hit_position.x < 2 and hit_position.y > GameUtility.brick_height - 2):
		# Lower left corner
		normal = Vector2(-0.5, 0.5)
	
	return normal.normalized()

func _on_action_pressed():
	_is_running = true;

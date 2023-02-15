extends KinematicBody2D

const player_container = preload("res://Assets/Prefabs/Player/PlayerContainer.tres")
const _main_scene = "res://Scenes/Main.tscn";

export var speed = 500;

onready var _visibility_notifier = $VisibilityNotifier;

var _direction = Vector2(0.5, 1);
var _is_running = false;

signal brick_hit(brick)

func _physics_process(delta):
	if Input.is_action_just_pressed("fire"):
		_is_running = true;
	
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
			_direction = _direction.bounce(collision.normal)
			
			if collision.collider.get_meta("Brick"):
				var brick = collision.collider
				emit_signal("brick_hit", brick)
				brick.hit()

func _check_game_over():
	if not _visibility_notifier.is_on_screen():
		print("Game over");
		get_tree().change_scene(_main_scene);

func get_x_bounce_direction(collision: KinematicCollision2D):
	var relative_x = collision.position.x - player_container.player.global_position.x
	var percentage = relative_x / player_container.player_width
	return percentage - 0.5 * 2 # should be in range [-1, 1]

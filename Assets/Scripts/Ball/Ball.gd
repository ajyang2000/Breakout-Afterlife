extends KinematicBody2D

export var speed = 500;

var _main_scene = "res://Scenes/Main.tscn";

var _direction = Vector2(0.5, 1);
var _is_running = false;

onready var _visibility_notifier = $VisibilityNotifier;

func _physics_process(delta):
	if Input.is_action_just_pressed("fire"):
		_is_running = true;
	
	if not _is_running:
		return
	
	_check_game_over();
	
	var velocity = speed * _direction * delta;
	var collision = move_and_collide(velocity);
	
	if (collision != null):
		_direction = _direction.bounce(collision.normal)

func _check_game_over():
	if not _visibility_notifier.is_on_screen():
		print("Game over");
		get_tree().change_scene(_main_scene);

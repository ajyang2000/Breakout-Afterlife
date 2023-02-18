extends "res://Assets/Scripts/Menus/Menu.gd"

const simple_title = "Breakout"
const special_title = "Breakout: Afterlife"

onready var _title_text = $VBoxContainer/Title

func _ready():
	_title_text.text = GameManager.get_title()
	visible = true

func _process(delta):
	if (Input.is_action_just_pressed("start")):
		change_scene(SceneTransition.main_menu_scene)

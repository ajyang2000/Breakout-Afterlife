extends "res://Assets/Scripts/Menus/Menu.gd"

const simple_title = "Breakout"
const special_title = "Breakout: Afterlife"

onready var _title_text = $VBoxContainer/Title

func _ready():
	_title_text.text = GameUtility.get_title()
	visible = true

func _process(delta):
	if (Input.is_action_pressed("action")):
		change_scene(main_menu_scene)

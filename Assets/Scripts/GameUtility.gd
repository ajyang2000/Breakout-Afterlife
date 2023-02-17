extends Node

const simple_title = "Breakout"
const special_title = "Breakout: Afterlife"
const brick_width = 48
const brick_height = 24

var is_afterlife = false

func get_title() -> String:
	return special_title if is_afterlife else simple_title

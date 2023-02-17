extends Node

const audio_manager = preload("res://Assets/Prefabs/Audio/AudioManager.tres")

func _ready():
	audio_manager.node = self

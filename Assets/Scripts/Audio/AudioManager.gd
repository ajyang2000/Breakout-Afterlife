extends Node

const audio_player_index = 0
const file_path_index = 1

enum SoundType{
	SFX0,
	SFX1,
	SFX2,
	SFX3,
	SFX4,
	SFX5,
	SFX6,
	SFX7,
	SFX8,
	SFX9
}

var _sfx_dict = {}
var _attached_sfx = []

func _ready():
	initialize()
	
func initialize():
	_sfx_dict[SoundType.SFX0] = [AudioStreamPlayer.new(), "res://Assets/SFX/sfx0.wav"]
	_sfx_dict[SoundType.SFX1] = [AudioStreamPlayer.new(), "res://Assets/SFX/sfx1.wav"]
	_sfx_dict[SoundType.SFX2] = [AudioStreamPlayer.new(), "res://Assets/SFX/sfx2.wav"]
	_sfx_dict[SoundType.SFX3] = [AudioStreamPlayer.new(), "res://Assets/SFX/sfx3.wav"]
	_sfx_dict[SoundType.SFX4] = [AudioStreamPlayer.new(), "res://Assets/SFX/sfx4.wav"]
	_sfx_dict[SoundType.SFX5] = [AudioStreamPlayer.new(), "res://Assets/SFX/sfx5.wav"]
	_sfx_dict[SoundType.SFX6] = [AudioStreamPlayer.new(), "res://Assets/SFX/sfx6.wav"]
	_sfx_dict[SoundType.SFX7] = [AudioStreamPlayer.new(), "res://Assets/SFX/sfx7.wav"]
	_sfx_dict[SoundType.SFX8] = [AudioStreamPlayer.new(), "res://Assets/SFX/sfx8.wav"]
	_sfx_dict[SoundType.SFX9] = [AudioStreamPlayer.new(), "res://Assets/SFX/sfx9.wav"]
	
func attach_sound(type):
	if type in _sfx_dict.keys() and not type in _attached_sfx:
		var audio_player = _sfx_dict[type][audio_player_index]
		var file_path = _sfx_dict[type][file_path_index]
		add_child(audio_player)
		audio_player.set_stream(load(file_path))
		_attached_sfx.append(type)

func play_sound(type, offset = 0):
	if type in _sfx_dict.keys():
		_sfx_dict[type][audio_player_index].play(offset)

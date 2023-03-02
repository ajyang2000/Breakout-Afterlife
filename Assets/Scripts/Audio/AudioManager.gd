extends Node

enum SFXType{
	SFX0,
	SFX1,
	SFX2,
	SFX3,
	SFX4,
	SFX5,
	SFX6,
	SFX7,
	SFX8,
	SFX9,
	TITLE_READ
}

enum MusicType{
	CLASSIC_CREDITS,
	TRUE_CREDITS,
	CLASSIC_MENU,
	TRUE_MENU,
	GAME
}

# List of SFX files
var _sfx_dict = {}

# List of music files
var _music_dict = {}

#List of playing audio
var _playing_sfx = {}
var _playing_music

var _available_players = []
var _queued_players = []

func _ready():
	_initialize_dictionaries()

func _process(_delta):
	if not _queued_players.empty():
		var audio_player = _queued_players.pop_front()
		audio_player.play()

func _initialize_dictionaries():
	_sfx_dict[SFXType.SFX0] = "res://Assets/SFX/sfx0.wav"
	_sfx_dict[SFXType.SFX1] = "res://Assets/SFX/sfx1.wav"
	_sfx_dict[SFXType.SFX2] = "res://Assets/SFX/sfx2.wav"
	_sfx_dict[SFXType.SFX3] = "res://Assets/SFX/shield_drop.wav"
	_sfx_dict[SFXType.SFX4] = "res://Assets/SFX/sfx4.wav"
	_sfx_dict[SFXType.SFX5] = "res://Assets/SFX/sfx5.wav"
	_sfx_dict[SFXType.SFX6] = "res://Assets/SFX/sfx6.wav"
	_sfx_dict[SFXType.SFX7] = "res://Assets/SFX/sfx7.wav"
	_sfx_dict[SFXType.SFX8] = "res://Assets/SFX/brick_break.wav"
	_sfx_dict[SFXType.SFX9] = "res://Assets/SFX/sfx9.wav"
	_sfx_dict[SFXType.TITLE_READ] = "res://Assets/SFX/title_read.wav"
	
	_music_dict[MusicType.CLASSIC_CREDITS] = "res://Assets/Music/classic_credits.mp3"
	_music_dict[MusicType.TRUE_CREDITS] = "res://Assets/Music/true_credits.mp3"
	_music_dict[MusicType.CLASSIC_MENU] = "res://Assets/Music/menu_classic.wav"
	_music_dict[MusicType.TRUE_MENU] = "res://Assets/Music/menu_afterlife.wav"
	_music_dict[MusicType.GAME] = "res://Assets/Music/Breakout Afterlife.mp3"
	

func play_sfx(type, offset = 0):
	if type in _sfx_dict.keys():
		var audio_player = _get_player(false, type)
		if (audio_player != null):
			_queued_players.append(audio_player)

func play_music(type, offset = 0):
	if type in _music_dict.keys():
		var audio_player = _get_player(true, type)
		if (audio_player != null):
			_queued_players.append(audio_player)

func stop_music():
	if _playing_music != null:
		_playing_music.stop()
	

func _get_player(is_music : bool, type : int) -> Node:
	var audio_dict = _music_dict if is_music else _sfx_dict
	
	if !audio_dict.keys().has(type):
		return null
	
	var audio_player
	if _available_players.empty():
		audio_player = AudioStreamPlayer.new()
		add_child(audio_player)
		audio_player.connect("finished", self, "_on_stream_finished", [audio_player])
	else:
		audio_player = _available_players.pop_front()
	audio_player.stream = load(audio_dict[type])
	
	if is_music:
		_playing_music = audio_player
	else:
		if not type in _playing_sfx.keys():
			_playing_sfx[type] = []
		_playing_sfx[type].append(audio_player)
	
	return audio_player
	
func _on_stream_finished(audio_player):
	for type in _playing_sfx.keys():
		var index = _playing_sfx[type].find(audio_player)
		if (index != -1):
			_playing_sfx[type].remove(index)
	
	
	if audio_player == _playing_music:
		_playing_music = null
	_available_players.append(audio_player)

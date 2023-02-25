extends "res://Assets/Scripts/Levels/LevelLoaders/LevelLoader.gd"

const level1 = "res://Scenes/Levels/ClassicLevel1.tscn"
const level2 = "res://Scenes/Levels/ClassicLevel2.tscn"
const level3 = "res://Scenes/Levels/ClassicLevel3.tscn"

func _load_levels():
	_levels.append(level1)
	_levels.append(level2)
	_levels.append(level3)

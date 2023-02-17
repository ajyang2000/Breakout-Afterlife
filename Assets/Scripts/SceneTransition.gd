extends CanvasLayer

const credits_scene = "res://Scenes/Menus/Credits.tscn"
const main_game_scene = "res://Scenes/Main.tscn"
const main_menu_scene = "res://Scenes/Menus/MainMenu.tscn"
const title_scene = "res://Scenes/Menus/TitleMenu.tscn"

var previous_scene : String

enum AnimationType{
	FADE
}

func change_scene(target: String, animationType = AnimationType.FADE):
	previous_scene = get_tree().current_scene.filename
	match animationType:
		AnimationType.FADE:
			$AnimationPlayer.play("Dissolve")
			yield($AnimationPlayer, "animation_finished")
			get_tree().change_scene(target)
			$AnimationPlayer.play_backwards("Dissolve")

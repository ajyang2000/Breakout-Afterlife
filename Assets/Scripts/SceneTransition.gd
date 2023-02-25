extends CanvasLayer

const credits_scene = "res://Scenes/Menus/Credits.tscn"
const main_game_scene = "res://Scenes/GameViews/Main.tscn"
const main_menu_scene = "res://Scenes/Menus/MainMenu.tscn"
const title_scene = "res://Scenes/Menus/TitleMenu.tscn"
const classic_game_scene = "res://Scenes/GameViews/ClassicMain.tscn"
const boss_game_scene = "res://Scenes/GameViews/MainBoss.tscn"

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
			if get_tree().change_scene(target) != OK:
				print("An unexpected error occured when trying to switch to %s" % target)
			$AnimationPlayer.play_backwards("Dissolve")

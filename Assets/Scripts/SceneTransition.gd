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

func change_scene_to_file(target: String, animationType = AnimationType.FADE):
	previous_scene = get_tree().current_scene.get_name()
	match animationType:
		AnimationType.FADE:
			$AnimationPlayer.play("Dissolve")
			await $AnimationPlayer.animation_finished
			if get_tree().change_scene_to_file(target) != OK:
				print("An unexpected error occured when trying to switch to %s" % target)
			$AnimationPlayer.play_backwards("Dissolve")

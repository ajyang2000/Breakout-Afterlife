extends CanvasLayer

enum AnimationType{
	FADE
}

func change_scene(target: String, animationType = AnimationType.FADE):
	match animationType:
		AnimationType.FADE:
			$AnimationPlayer.play("Dissolve")
			yield($AnimationPlayer, "animation_finished")
			get_tree().change_scene(target)
			$AnimationPlayer.play_backwards("Dissolve")

extends Button

const SCENE_PATH: String = "res://scenes/MainGame.tscn"

func _on_pressed():
	get_tree().change_scene_to_file(SCENE_PATH)

extends Control


class_name MainMenu



func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_start_pressed() -> void:
	SceneManager.change_game_scene()

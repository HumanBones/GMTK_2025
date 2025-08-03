extends Node

const WORLD = preload("res://Scenes/World/world.tscn")
const MAIN_MENU = preload("res://Scenes/MainMenu/main_menu.tscn")


func change_game_scene() ->void:
	get_tree().change_scene_to_packed(WORLD)
	
func change_menu_scene() ->void:
	get_tree().change_scene_to_packed(MAIN_MENU)

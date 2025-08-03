extends Node

const WORLD = preload("res://Scenes/World/world.tscn")
const MAIN_MENU = preload("res://Scenes/MainMenu/main_menu.tscn")
const WIN_PAGE = preload("res://Scenes/WinScene/win_page.tscn")


func _ready() -> void:
	GameManager.win.connect(change_win_scene)

func change_game_scene() ->void:
	get_tree().change_scene_to_packed(WORLD)
	
func change_menu_scene() ->void:
	get_tree().change_scene_to_packed(MAIN_MENU)

func change_win_scene() ->void:
	get_tree().call_deferred("change_scene_to_packed",WIN_PAGE)

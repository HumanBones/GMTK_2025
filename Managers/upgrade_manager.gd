extends Node

signal one_more_card

var player_upgrade_manager : PlayerUpgradeManager

var upgrade_list : Array[Upgrade]

func _ready() -> void:
	player_upgrade_manager = get_tree().get_first_node_in_group("PlayerUpgradeManager")


func dmg(amount : float, upgrade : Upgrade) ->void:
	player_upgrade_manager.dmg(amount)
	upgrade_list.append(upgrade)
	
func speed(amount: float,upgrade : Upgrade) ->void:
	player_upgrade_manager.speed(amount)
	
func hp(amount : int,upgrade : Upgrade) ->void:
	player_upgrade_manager.hp(amount)
	upgrade_list.append(upgrade)
	GameManager.start.emit()

func attack_speed(amount : int,upgrade : Upgrade) ->void:
	player_upgrade_manager.attack_speed(amount)

func card_upgrade() ->void:
	one_more_card.emit()

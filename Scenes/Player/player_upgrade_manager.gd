extends Node2D

class_name PlayerUpgradeManager

@export var health_manager : HealthManager
@export var player : Player
@export var attack_manager : AttackManager



func dmg(amount : float) ->void:
	attack_manager.set_dmg(amount)
	
func speed(amount: float) ->void:
	player.set_speed(amount)
	
func hp(amount : int) ->void:
	health_manager.set_hp(amount)

func attack_speed(amount : int) ->void:
	attack_manager.set_attack_speed(amount)

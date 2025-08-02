extends CharacterBody2D

class_name Enemy

signal dmg_taken(amount)

@export var max_speed : float

var target : CharacterBody2D
var speed : float

func _ready() -> void:
	speed = max_speed

func die() ->void:
	call_deferred("queue_free")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		area.die()
		dmg_taken.emit(area.get_dmg())

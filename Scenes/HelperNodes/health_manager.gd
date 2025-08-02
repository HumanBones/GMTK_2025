extends Node2D

class_name HealthManager

signal hp_lowerd
signal hp_rised
signal died
signal hp_changed(amount : float)

@export var max_hp : int
@export var parent : CharacterBody2D

@onready var label: Label = $Label

var hp : int

func _ready() -> void:
	
	label.text = str(max_hp)
	hp = max_hp
	parent.dmg_taken.connect(take_dmg)
	hp_changed.connect(update_label)

func max_hp_chaned(amount : int) ->void:
	max_hp = amount
	if amount > max_hp:
		hp_rised.emit()
	else:
		hp_lowerd.emit()

func take_dmg(amount : int) ->void:
	hp -= amount
	if hp < 0:
		died.emit()
	
	hp_changed.emit(hp)

func heal(amount : int) ->void:
	if hp >= max_hp:
		return
	
	hp += amount
	hp = clamp(hp,0,max_hp)
	
	hp_changed.emit(hp)

func update_label(amount : float) ->void:
	label.text = str(hp)

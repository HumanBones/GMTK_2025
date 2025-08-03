extends Node2D

class_name HealthManager

signal hp_lowerd
signal hp_rised
signal died
signal hp_changed(amount : float)
signal init(hp : int)
signal clear

@export var max_hp : int
@export var parent : CharacterBody2D
@export var dmg_shake_amount : float

@onready var label: Label = $Label

var hp : int

func _ready() -> void:
	GameManager.looping.connect(reset_everything)
	label.text = str(max_hp)
	hp = max_hp
	parent.dmg_taken.connect(take_dmg)
	init.emit(hp)

func max_hp_chaned(amount : int) ->void:
	max_hp = amount
	if amount > max_hp:
		hp_rised.emit()
	else:
		hp_lowerd.emit()

func take_dmg(amount : int) ->void:
	hp -= amount
	GameManager.shake.emit(dmg_shake_amount)
	if hp <= 0:
		died.emit()
	hp_changed.emit(hp)
	update_label(amount)

func heal(amount : int) ->void:
	if hp >= max_hp:
		return
	
	hp += amount
	hp = clamp(hp,0,max_hp)
	
	hp_changed.emit(hp)
	update_label(amount)

func update_label(amount : float) ->void:
	label.text = str(hp)

func set_hp(amount : int) ->void:
	max_hp = amount
	hp = max_hp
	update_label(hp)
	hp_changed.emit(hp)
	clear.emit()
	init.emit(hp)

func reset_everything() ->void:
	hp = max_hp

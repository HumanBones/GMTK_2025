extends Control

class_name Card

@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/TextureRect
@onready var label: Label = $MarginContainer/VBoxContainer/Label
@onready var button: Button = $MarginContainer/VBoxContainer/Button

@export var upgrade_list : Array[Upgrade]
@export var curse_list : Array[Upgrade]
@export var curse_chance : float

var upgrade : Upgrade

func _ready() -> void:
	pick_random_upgrade()
	label.text = upgrade.description
	texture_rect.texture = upgrade.icon

func _on_button_pressed() -> void:
	upgrade.apply_upgrade()

func pick_random_upgrade() ->void:
	if randf() < curse_chance:
		upgrade = curse_list.pick_random()
	else:
		upgrade = upgrade_list.pick_random()

extends Control

class_name Card

@export var power_up : Node2D

@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/TextureRect
@onready var label: Label = $MarginContainer/VBoxContainer/Label
@onready var button: Button = $MarginContainer/VBoxContainer/Button

@export var upgrade : Upgrade

func _ready() -> void:
	#label.text = upgrade.description
	#texture_rect.texture = upgrade.icon
	pass

func _on_button_pressed() -> void:
	GameManager.start.emit()

extends Control

class_name PowerUP

@export var cards_amount : int
@onready var h_box_container: HBoxContainer = $MarginContainer/HBoxContainer
const CARD = preload("res://Scenes/UI/PowerUP/card.tscn")

func _ready() -> void:
	GameManager.looping.connect(show_powerup)
	GameManager.start.connect(hide_powerup)
	UpgradeManager.one_more_card.connect(set_card_amount)

func spawn_cards() ->void:
	for cards in cards_amount:
		var cards_inst = CARD.instantiate() as Card
		h_box_container.add_child(cards_inst)

func show_powerup() ->void:
	spawn_cards()
	self.show()
	
func hide_powerup() ->void:
	clear_cards()
	self.hide()

func clear_cards() ->void:
	var card_list = h_box_container.get_children()
	for child in card_list:
		child.queue_free()

func set_card_amount() ->void:
	cards_amount += 1

extends Control

class_name WaveUI

@onready var label: Label = $MarginContainer/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	hide()
	SpawnManager.next_wave.connect(label_text)
	

func label_text(amount : int) ->void:
	show()
	label.text = "Next wave " + str(amount)
	
func hide_self() ->void:
	hide()

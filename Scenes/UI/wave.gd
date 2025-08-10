extends Control

class_name WaveUI

@onready var label: Label = $MarginContainer/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	hide()
	SpawnManager.next_wave.connect(label_text)
	

func label_text(amount : int) ->void:
	show()
	label.text = "Next wave"
	animation_player.play("fade_out_label")
	
func hide_self() ->void:
	hide()

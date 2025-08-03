extends Control

class_name PowerUP

func _ready() -> void:
	GameManager.looping.connect(show_powerup)
	GameManager.start.connect(hide_powerup)

func show_powerup() ->void:
	self.show()
	
func hide_powerup() ->void:
	self.hide()

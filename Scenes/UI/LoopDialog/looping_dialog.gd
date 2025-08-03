extends Control

class_name LoopDialog

@onready var label: Label = $MarginContainer/VBoxContainer/Label
@onready var label_2: Label = $MarginContainer/VBoxContainer/Label2
@onready var label_3: Label = $MarginContainer/VBoxContainer/Label3
@onready var timer: Timer = $Timer

var count : int = 0
var is_first_time :bool = true

func _ready() -> void:
	GameManager.pause.connect(start_timer)

func start_timer() ->void:
	if is_first_time:
		show()
		timer.start()
	else:
		GameManager.looping.emit()


func _on_timer_timeout() -> void:
	match count:
		0:
			label.show()
		1:
			label_2.show()
		2:
			label_3.show()
		3:
			timer.stop()
			GameManager.looping.emit()
			hide()
			is_first_time = false
	
	count += 1

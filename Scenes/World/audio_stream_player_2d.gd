extends AudioStreamPlayer2D

func _ready() -> void:
	GameManager.pause.connect(play_when)

func play_when() ->void:
	play()

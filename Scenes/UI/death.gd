extends AudioStreamPlayer2D


func _on_timer_timeout() -> void:
	call_deferred("queue_free")

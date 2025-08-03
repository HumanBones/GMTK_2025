extends CPUParticles2D

class_name Explosion

func _ready() -> void:
	emitting = true

func _on_timer_timeout() -> void:
	self.call_deferred("queue_free")

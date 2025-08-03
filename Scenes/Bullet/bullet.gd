extends Area2D

class_name Bullet

@export var max_speed : float
@export var life_time : float
@export var max_dmg : float

@onready var timer: Timer = $Timer

var speed : float
var direction : Vector2
var dmg : float


func _ready() -> void:
	speed = max_speed
	timer.wait_time = life_time
	dmg = max_dmg

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func set_dmg(amount : float) ->void:
	max_dmg = amount

func get_dmg() -> float:
	return dmg

func die() -> void:
	call_deferred("queue_free")

func _on_timer_timeout() -> void:
	die()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	die()

func set_bullet_speed(amount : float) ->void:
	max_speed = amount
	speed = max_speed

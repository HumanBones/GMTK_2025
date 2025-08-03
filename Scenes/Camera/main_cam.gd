extends Camera2D

class_name MainCam

@export var target : CharacterBody2D
@export var max_speed : float
@export var max_acc : float
@export var max_follow_dist : float

@export var shake_strength : float
@export var shake_amount : float
@export var shake_decay : float

var speed : float
var acc : float
var follow_dist : float


func _ready() -> void:
	GameManager.shake.connect(shake)
	speed = max_speed
	acc = max_acc
	follow_dist = max_follow_dist


func _physics_process(delta: float) -> void:
	if target == null:
		print("No target to follow")
		return
		
	if global_position.distance_squared_to(target.global_position) > follow_dist*follow_dist:
		global_position = global_position.lerp(target.global_position,delta*acc*speed)
	
func _process(delta: float) -> void:
	if shake_strength > 0.0:
		var cam_offset = Vector2( randf_range(-1.0,1.0),randf_range(-1.0,1.0)) * shake_amount * shake_strength
		cam_offset = cam_offset.round()
		offset = cam_offset
		shake_strength = max(shake_strength - shake_decay * delta, 0.0)
		
	else:
		offset = Vector2.ZERO

func shake(amount : float) -> void:
	shake_strength = amount

extends Camera2D

class_name MainCam

@export var target : CharacterBody2D
@export var max_speed : float
@export var max_acc : float
@export var max_follow_dist : float

var speed : float
var acc : float
var follow_dist : float


func _ready() -> void:
	speed = max_speed
	acc = max_acc
	follow_dist = max_follow_dist


func _physics_process(delta: float) -> void:
	if target == null:
		print("No target to follow")
		return
		
	if global_position.distance_squared_to(target.global_position) > follow_dist*follow_dist:
		global_position = global_position.lerp(target.global_position,delta*acc*speed)
	

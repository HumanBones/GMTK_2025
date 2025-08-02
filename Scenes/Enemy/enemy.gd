extends CharacterBody2D

class_name Enemy

signal dmg_taken(amount)

@export var max_dmg : float
@export var max_speed : float
@export var is_ranged : bool
@export var max_target_dist_melee : float
@export var max_target_dist_range : float
@export var max_attack_range_melee : float
@export var max_attack_range_range : float

@export var offset : float

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

var target : Player
var speed : float
var dist_to_target : float
var direction : Vector2
var dmg : float
var is_player_dead : bool = false

func _ready() -> void:
	dmg = max_dmg
	speed = max_speed
	target = get_tree().get_first_node_in_group("Player")
	if is_ranged:
		dist_to_target = max_target_dist_range
	else:
		dist_to_target = max_target_dist_melee
		

func _physics_process(delta: float) -> void:
	if target == null:
		return
	
	navigation_agent_2d.target_position = target.global_position
	if global_position.distance_squared_to(target.global_position) > dist_to_target*dist_to_target:
		direction = navigation_agent_2d.get_next_path_position() - global_position
		direction = direction.normalized()
	
	else:
		direction = Vector2.ZERO
		attack()
	
	velocity = direction * speed
	
	move_and_slide()

func die() ->void:
	call_deferred("queue_free")

func get_dmg() -> float:
	return dmg

func attack() ->void:
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		dmg_taken.emit(area.get_dmg())
		area.die()

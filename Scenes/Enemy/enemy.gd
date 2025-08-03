extends CharacterBody2D

class_name Enemy

signal dmg_taken(amount)
signal died(enemy : Enemy)
signal shoot(dir : Vector2)

const EXPLOSION = preload("res://Scenes/Particles/explosion.tscn")

@export var max_dmg : float
@export var max_speed : float
@export var is_ranged : bool
@export var max_target_dist_melee : float
@export var max_target_dist_range : float
@export var max_attack_range_melee : float
@export var max_attack_range_range : float
@export var shake_death_amount : float
@export var offset : float
@export var attack_speed : float

@onready var attack_manager: AttackManager = $AttackManager
@onready var collision_shape_2d: CollisionShape2D = $Attack/CollisionShape2D
@onready var attack: Area2D = $Attack
@onready var timer: Timer = $Timer
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

var is_attacking : bool = false
var target : Player
var speed : float
var dist_to_target : float
var direction : Vector2
var dmg : float
var is_player_dead : bool = false
var particle_holder : Node2D

func _ready() -> void:
	timer.wait_time = attack_speed
	particle_holder = get_tree().get_first_node_in_group("ParticleHolder")
	dmg = max_dmg
	speed = max_speed
	target = get_tree().get_first_node_in_group("Player")
	collision_shape_2d.disabled = true
	if is_ranged:
		dist_to_target = max_target_dist_range
	else:
		dist_to_target = max_target_dist_melee
		
	GameManager.looping.connect(stop_all)

func _physics_process(delta: float) -> void:
	if target == null:
		return
	
	navigation_agent_2d.target_position = target.global_position
	if global_position.distance_squared_to(target.global_position) > dist_to_target*dist_to_target:
		direction = navigation_agent_2d.get_next_path_position() - global_position
		direction = direction.normalized()
	
	else:
		direction = Vector2.ZERO
		var dir = target.global_position - Vector2(global_position.x,global_position.y+offset)
		dir.normalized()
		hit(dir)
	
	velocity = direction * speed
	
	move_and_slide()

func die() ->void:
	spawn_particle()
	GameManager.shake.emit(shake_death_amount)
	died.emit(self)
	call_deferred("queue_free")

func get_dmg() -> float:
	return dmg

func hit(dir : Vector2) ->void:
	if is_ranged:
		attack_manager.spawn_bullet(dir)
		
	else:
		var angle = dir.angle()
		attack.rotation = angle
		collision_shape_2d.disabled = false

func stop_all() ->void:
	set_physics_process(false)
	set_process(false)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		dmg_taken.emit(area.get_dmg())
		area.die()

func spawn_particle() ->void:
	var particle_inst = EXPLOSION.instantiate() as Explosion
	particle_inst.global_position = self.global_position
	particle_holder.add_child(particle_inst)

func _on_timer_timeout() -> void:
	is_attacking = true
	collision_shape_2d.disabled = true

func _on_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") && is_attacking:
		area.get_parent().dmg_taken.emit(dmg)
	is_attacking = false
	timer.start()

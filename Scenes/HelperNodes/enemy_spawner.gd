extends Node2D

class_name EnemySpawner

const ENEMY = preload("res://Scenes/Enemy/enemy.tscn")
const RANGE_ENEMY = preload("res://Scenes/WinScene/range_enemy.tscn")
@export var spawn_range : float
@export var enemy_to_spawn : int
@export var spawn_rate : float
@export var chance : float 

@onready var timer: Timer = $Timer

var spawned_enemies : int = 0
var enemy_holder : Node2D
var finished : bool = false
var can_spawn : bool = true


func _ready() -> void:
	enemy_holder = get_tree().get_first_node_in_group("EnemyHolder")
	timer.wait_time = spawn_rate
	SpawnManager.add_spawner(self)
	SpawnManager.next_wave.connect(next_wave)
	GameManager.pause.connect(reset_spawner)
	GameManager.start.connect(resume_spawner)

func spawn_enemy() ->void:
	if !can_spawn:
		return
	var enemy_inst : Enemy
	if randf() < chance:
		enemy_inst = RANGE_ENEMY.instantiate() as Enemy
	else:
		enemy_inst = ENEMY.instantiate() as Enemy
		
	enemy_inst.global_position = get_spawn_point()
	enemy_holder.add_child(enemy_inst)
	SpawnManager.enemy_spawned(enemy_inst)
	enemy_inst.died.connect(SpawnManager.enemy_died)

	spawned_enemies += 1
	
	if spawned_enemies < enemy_to_spawn:
		can_spawn = false
	else:
		timer.stop()
		finished = true
		can_spawn = false

func get_spawn_point() -> Vector2:
	var new_point : Vector2
	new_point = global_position
	return new_point

func next_wave(wave : float) ->void:
	timer.start()
	spawned_enemies = 0
	finished = false
	can_spawn = true

func reset_spawner() ->void:
	finished = false
	can_spawn = false
	spawned_enemies = 0
	timer.stop()

func resume_spawner() ->void:
	can_spawn = true
	timer.start()

func _on_timer_timeout() -> void:
	can_spawn = true
	spawn_enemy()

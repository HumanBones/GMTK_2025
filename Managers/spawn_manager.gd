extends Node

signal next_wave
signal waves_finished

var wave_amount : int = 2
var cur_wave : int = 0
var enemy_kill_count : int = 0
var enemy_list : Array[Enemy]
var spawner_list : Array[EnemySpawner]
var is_spawning_finished : bool = false

func _ready() -> void:
	GameManager.looping.connect(clear_enemies)

func add_spawner(spawner : EnemySpawner) ->void:
	spawner_list.append(spawner)

func enemy_spawned(enemy_inst :Enemy) ->void:
	enemy_list.append(enemy_inst)

func enemy_died(enemy_inst : Enemy) ->void:
	enemy_list.erase(enemy_inst)
	enemy_kill_count += 1
	if enemy_list.is_empty() && spawning_finished():
		print("next wave")
		if cur_wave < wave_amount:
			cur_wave += 1
			print("cur_wave",cur_wave)
			next_wave.emit()

func spawning_finished() ->bool:
	for spawner in spawner_list:
		if spawner.finished == false:
			return false
	return true

func clear_enemies() ->void:

	for enemy in enemy_list:
		if enemy == null:
			return
		enemy.queue_free()
	
	enemy_list.clear()

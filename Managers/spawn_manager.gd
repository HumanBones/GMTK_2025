extends Node

signal next_wave(amount : int)
signal waves_finished
signal enemy_killed(amount : int)

var wave_amount : int = 2
var cur_wave : int = 0
var enemy_kill_count : int = 0
var enemy_list : Array[Enemy]
var spawner_list : Array[EnemySpawner]
var is_spawning_finished : bool = false

func _ready() -> void:
	GameManager.pause.connect(clear_enemies)
	GameManager.looping.connect(reset_wave_count)

func add_spawner(spawner : EnemySpawner) ->void:
	spawner_list.append(spawner)

func enemy_spawned(enemy_inst :Enemy) ->void:
	enemy_list.append(enemy_inst)

func enemy_died(enemy_inst : Enemy) ->void:
	enemy_list.erase(enemy_inst)
	enemy_kill_count += 1
	enemy_killed.emit(enemy_kill_count)
	if enemy_list.is_empty() && spawning_finished():
		if cur_wave < wave_amount:
			cur_wave += 1
			next_wave.emit(cur_wave)
		else:
			SceneManager.change_win_scene()

func spawning_finished() ->bool:
	for spawner in spawner_list:
		if spawner != null:
			if spawner.finished == false:
				return false
	return true

func clear_enemies() ->void:

	for enemy in enemy_list:
		if enemy == null:
			return
		enemy.queue_free()
	
	enemy_list.clear()

func reset_wave_count() ->void:
	cur_wave = 0
	enemy_kill_count = 0
	enemy_killed.emit(enemy_kill_count)

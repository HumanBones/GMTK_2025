extends Node2D

class_name AttackManager

@export var bullet : PackedScene
@export var parent : CharacterBody2D
@export var max_dmg : float
@export var attack_speed : float
@export var shoot_position : Marker2D
@export var bullet_speed : float

@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var dmg : float
var can_attack : bool = true
var bullet_holder : Node2D

func _ready() -> void:
	dmg = max_dmg
	timer.wait_time = attack_speed
	bullet_holder = get_tree().get_first_node_in_group("BulletHolder")
	
	if parent == null:
		return
	
	parent.shoot.connect(spawn_bullet)
	
func spawn_bullet(dir : Vector2) ->void:
	if bullet == null:
		return
	if !can_attack:
		return
	
	audio_stream_player_2d.play()
	var bullet_inst = bullet.instantiate() as Bullet
	bullet_inst.set_dmg(dmg)
	bullet_inst.set_bullet_speed(bullet_speed)
	bullet_inst.direction = dir
	bullet_inst.global_position = shoot_position.global_position
	bullet_holder.add_child(bullet_inst)
	can_attack = false
	timer.start()

func set_attack_speed(amount : float) ->void:
	attack_speed *= amount
	timer.wait_time = attack_speed

func set_dmg(amount : float) ->void:
	max_dmg *= amount
	dmg = max_dmg

func _on_timer_timeout() -> void:
	can_attack = true

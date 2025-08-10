extends CharacterBody2D

class_name Player

signal dmg_taken(amount : int)
signal healed(amount : int)
signal shoot(dir : Vector2)
signal player_dead
signal init_ui(hp : int)
signal reset
signal clear

@export var max_speed : float
@export var limit_speed : float

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var speed : float
var direction : Vector2
var is_moving : bool = false
var shoot_dir : Vector2 = Vector2.ZERO
var cur_spawn_pos : Vector2

func _ready() -> void:
	speed = max_speed
	cur_spawn_pos = global_position
	GameManager.pause.connect(reset_everything)
	GameManager.looping.connect(reset_hp)
	GameManager.start.connect(resume_everything)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _physics_process(delta: float) -> void:
	move_input()
	shoot_input()
	
	velocity = speed * direction
	
	move_and_slide()
	
	if direction:
		is_moving = true
	else:
		is_moving = false
	
	handle_animations()
	handle_sprite_flip()

func shoot_input() ->void:
	
	if Input.is_action_pressed("shoot_left"):
		shoot_dir = Vector2.LEFT
		handle_shoot_sprie_flip(-1)
		shoot.emit(shoot_dir)
	if Input.is_action_pressed("shoot_right"):
		shoot_dir = Vector2.RIGHT
		handle_shoot_sprie_flip(1)
		shoot.emit(shoot_dir)
	if Input.is_action_pressed("shoot_up"):
		shoot_dir = Vector2.UP
		shoot.emit(shoot_dir)
	if Input.is_action_pressed("shoot_down"):
		shoot_dir = Vector2.DOWN
		shoot.emit(shoot_dir)

func move_input() ->void:
	direction = Vector2.ZERO
	var move_x = Input.get_axis("left","right")
	var move_y = Input.get_axis("up","down")
	
	direction = Vector2(move_x,move_y).normalized()

func handle_animations() ->void:
	if is_moving:
		animation_player.play("walk")
	else:
		animation_player.play("idle")

func handle_sprite_flip() ->void:
	if direction.x < 0:
		sprite_2d.flip_h = true
	if direction.x > 0:
		sprite_2d.flip_h = false

func handle_shoot_sprie_flip(amount: int) ->void:
	if amount <0:
		sprite_2d.flip_h = true
	if amount > 0:
		sprite_2d.flip_h = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("EnemyBullet"):
		dmg_taken.emit(area.get_dmg())
		area.die()
	
	if area.is_in_group("Enemy"):
		dmg_taken.emit(area.get_parent().get_dmg())

func reset_everything() ->void:
	global_position = cur_spawn_pos

func reset_hp() ->void:
	reset.emit()

func resume_everything() ->void:
	set_physics_process(true)

func die() ->void:
	player_dead.emit()
	GameManager.pause.emit()
	set_physics_process(false)
	animation_player.stop()
	
func set_speed(amount : float) ->void:
	max_speed *= amount
	if max_speed > limit_speed:
		max_speed = limit_speed
	speed = max_speed

func clear_ui() ->void:
	clear.emit()

func init_health_ui(hp : int) ->void:
	init_ui.emit(hp)

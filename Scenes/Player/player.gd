extends CharacterBody2D

class_name Player

signal dmg_taken(amount : int)
signal shoot(dir : Vector2)

@export var max_speed : float

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var speed : float
var direction : Vector2
var is_moving : bool = false
var shoot_dir : Vector2 = Vector2.ZERO

func _ready() -> void:
	speed = max_speed

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	

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

func die() ->void:
	set_physics_process(false)
	animation_player.stop()

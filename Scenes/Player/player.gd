extends CharacterBody2D

class_name Player

@export var max_speed : float

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var speed : float
var direction : Vector2
var is_moving : bool = false

func _ready() -> void:
	speed = max_speed

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	

func _physics_process(delta: float) -> void:
	user_input()
	
	velocity = speed * direction
	
	move_and_slide()
	
	if direction:
		is_moving = true
	else:
		is_moving = false
	
	handle_animations()
	handle_sprite_flip()

func user_input() ->void:
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

extends Control

class_name HealthUI

const HEARTH_UI = preload("res://Scenes/UI/HearthUI/hearth_ui.tscn")

@onready var container: HBoxContainer = $MarginContainer/Container
@onready var texture_rect: TextureRect = $TextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer



var hearth_list : Array[Hearth]
var hp_manager : HealthManager

	
func init_ui(hp : int) ->void:
	for h in hp:
		add_hearth()

func hp_lowered(amount : int) ->void:
	texture_rect.show()
	animation_player.play("fade_out")
	for i in range(hearth_list.size()-1,-1,-1):
		if hearth_list[i].is_full:
			hearth_list[i].set_empty()
			break

func hp_halfed(amount : int) ->void:
	pass
	
func hp_filled(amount : int) ->void:
	for hp in hearth_list:
		if hp.is_empty:
			hp.set_full()
			break
			
func add_hearth() ->void:
	var hearth_inst =  HEARTH_UI.instantiate() as Hearth
	container.add_child(hearth_inst)
	hearth_inst.set_full()
	hearth_list.append(hearth_inst)
	
func clear_list() ->void:
	if hearth_list.is_empty():
		return
	for hp in hearth_list:
		hp.queue_free()
	hearth_list.clear()

func  reset() -> void:
	for hp in hearth_list:
		hp.set_full()

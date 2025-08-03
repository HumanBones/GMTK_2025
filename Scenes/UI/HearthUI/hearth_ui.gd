extends TextureRect

class_name Hearth


const HEARTH_UI_EMPTY = preload("res://Assets/UI/hearth_ui_empty.png")
const HEARTH_UI_FULL = preload("res://Assets/UI/hearth_ui_full.png")
const HEARTH_UI_HALF = preload("res://Assets/UI/hearth_ui_half.png")


var is_empty : bool = false
var is_half : bool = false
var is_full : bool = true


func update_texture() ->void:
	if is_empty:
		texture = HEARTH_UI_EMPTY
	elif is_half:
		texture = HEARTH_UI_HALF
	else:
		texture = HEARTH_UI_FULL

func set_empty() ->void:
	is_empty = true
	is_half = false
	is_full = false
	update_texture()
	
func set_full() ->void:
	is_empty = false
	is_half = false
	is_full = true
	update_texture()
	
func set_half() ->void:
	is_empty = false
	is_half = true
	is_full = false
	update_texture()

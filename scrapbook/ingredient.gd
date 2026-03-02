@tool
extends Area2D

@export var ingredient_texture: Texture2D
@export var layer_texture: Texture2D
@export var ingredient_name: String
@onready var sprite: Sprite2D = $Sprite2D

var dragging := false
var start_pos: Vector2

func _ready() -> void:
	start_pos = global_position
	_apply_texture()


func set_ingredient_texture(value: Texture2D) -> void:
	ingredient_texture = value
	_apply_texture()

func _apply_texture() -> void:
	if not is_instance_valid(sprite):
		return
	sprite.texture = ingredient_texture
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
		else:
			dragging = false
			_drop_or_return()

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position()

func _drop_or_return() -> void:
	var game := get_tree().current_scene
	var overlapped := get_overlapping_areas()

	for a in overlapped:
		if a.is_in_group("drop_zone"):
			if game.has_method("add_layer"):
				game.add_layer(ingredient_name, layer_texture)

			global_position = start_pos
			return

	global_position = start_pos

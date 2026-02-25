@tool
extends Area2D

@export var ingredient_name: String = ""
@export var ingredient_texture: Texture2D

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

	var layers_container := game.get_node("GlassArea/LayersContainer") as Node2D
	var drop_point := game.get_node("GlassArea/DropZone/DropPoint") as Node2D

	var overlapped := get_overlapping_areas()

	for a in overlapped:
		if a.is_in_group("drop_zone"):
			# Create the layer sprite
			var layer_sprite := Sprite2D.new()
			layer_sprite.texture = ingredient_texture
			layer_sprite.centered = true

			layer_sprite.scale = Vector2(1, 1)

			
			layers_container.add_child(layer_sprite)

			var base_pos: Vector2 = layers_container.to_local(drop_point.global_position)

			var y_offset := 0.0
			for child in layers_container.get_children():
				if child == layer_sprite:
					continue
				if child is Sprite2D and (child as Sprite2D).texture:
					var s := child as Sprite2D
					var h := float(s.texture.get_size().y) * s.scale.y
					y_offset += h

			layer_sprite.position = base_pos + Vector2(0, -y_offset)

			layer_sprite.z_as_relative = false
			layer_sprite.z_index = 500 + layers_container.get_child_count()

	# Reset draggable back to shelf
	global_position = start_pos
	return

	# Not dropped in cup
	global_position = start_pos

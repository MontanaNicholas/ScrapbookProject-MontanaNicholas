extends Area2D

@export var ingredient_name: String = ""
@export var ingredient_texture: Texture2D

@onready var sprite: Sprite2D = $Sprite2D

var dragging := false
var start_pos: Vector2

func _ready() -> void:
	start_pos = global_position
	if ingredient_texture:
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
	var overlapped := get_overlapping_areas()

	for a in overlapped:
		if a.is_in_group("drop_zone"):
			var layers_container = get_tree().current_scene.get_node("GlassArea/LayersContainer")

			var layer_sprite := Sprite2D.new()
			layer_sprite.texture = ingredient_texture
			layer_sprite.centered = true
			layer_sprite.scale = sprite.scale

			# Stack vertically based on number of layers
			var layer_count = layers_container.get_child_count()
			layer_sprite.position = Vector2(0, -layer_count * 20)

			layers_container.add_child(layer_sprite)

			# Reset draggable back to shelf
			global_position = start_pos
			return

	
	global_position = start_pos

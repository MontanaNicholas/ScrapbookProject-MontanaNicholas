extends Node2D

signal candle_extinguished

var is_lit := false

@onready var flame = get_node_or_null("pivot/flameSprite")
@onready var click_area: Area2D = $clickArea

func _ready():
	# Start unlit
	if flame:
		flame.visible = false
	click_area.input_event.connect(_on_input_event)

func light():
	is_lit = true
	if flame:
		flame.visible = true

func extinguish(emit_signal := false):
	is_lit = false
	if flame:
		flame.visible = false

	if emit_signal:
		emit_signal("candle_extinguished")

func _on_input_event(_viewport, event, _shape_idx):
	# Only clickable when lit
	if not is_lit:
		return

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Candle clicked while lit!")
		extinguish(true)

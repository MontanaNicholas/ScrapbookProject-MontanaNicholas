extends Node2D

signal candle_extinguished

var is_lit := true
@onready var flame = get_node_or_null("pivot/flameSprite")
@onready var click_area = $clickArea

func _ready():
	click_area.input_event.connect(_on_input_event)

func _on_input_event(_viewport, event, _shape_idx):
	if not is_lit:
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		extinguish()

func extinguish():
	is_lit = false

	if flame:
		flame.visible = false

	print("Candle extinguished!")
	emit_signal("candle_extinguished")

extends Node2D

@export var candle_scene: PackedScene
@onready var candles_container = $candles
@onready var candle_spot_1 = $cake/candleSpot1
@export var candle_row_offset := Vector2(40, -10)
@export var candle_spacing := 35.0

var remaining := 0
@export var candle_count := 5

func _ready():
	remaining = candle_count
	print("Candles at start:", remaining)
	spawn_candles()
	
func spawn_candles():
	for i in range(candle_count):
		var candle = candle_scene.instantiate()
		candles_container.add_child(candle)

		var offset_x = (i - (candle_count - 1) / 2.0) * candle_spacing
		candle.global_position = candle_spot_1.global_position + Vector2(offset_x, 0) + candle_row_offset


		if candle.has_signal("candle_extinguished"):
			candle.connect("candle_extinguished", _on_candle_extinguished)

func _on_candle_extinguished():
	remaining -= 1
	print("Candle blown out. Remaining:", remaining)
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://BirthdayMinigame-help.tscn")
	

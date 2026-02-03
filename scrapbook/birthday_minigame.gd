extends Node2D

@export var candle_scene: PackedScene

@onready var candles_container = $candles
@onready var candle_spot_1 = $cake/candleSpot1
@onready var win_ui: Control = $UI/winUI

@export var candle_row_offset := Vector2(40, -10)
@export var candle_spacing := 35.0

@export var candle_count := 5
var remaining := 0

# Timed mode settings
@export var light_interval := 0.6   # gap before next candle lights
@export var lit_duration := 1.2     # how long a candle stays lit

var candle_nodes: Array = []
var lit_candle = null


func _ready():
	win_ui.visible = false

	remaining = candle_count
	print("Candles to successfully blow out:", remaining)

	spawn_candles()
	start_timed_candles()


func spawn_candles():
	candle_nodes.clear()

	for i in range(candle_count):
		var candle = candle_scene.instantiate()
		candles_container.add_child(candle)
		candle_nodes.append(candle)

		var offset_x = (i - (candle_count - 1) / 2.0) * candle_spacing
		candle.global_position = candle_spot_1.global_position + Vector2(offset_x, 0) + candle_row_offset

		# connect candle signal, decreases remaining only when clicked while lit
		if candle.has_signal("candle_extinguished"):
			candle.connect("candle_extinguished", _on_candle_extinguished)


func start_timed_candles():
	_run_timed_loop()

func _turn_off_current_lit():
	if lit_candle and lit_candle.is_lit:
		lit_candle.extinguish(false)


func _run_timed_loop() -> void:
	if candle_nodes.is_empty():
		print("No candles found!")
		return

	while remaining > 0:
		_turn_off_current_lit()

		lit_candle = candle_nodes.pick_random()
		if lit_candle:
			lit_candle.light()

		await get_tree().create_timer(lit_duration, false).timeout

		if lit_candle and lit_candle.is_lit:
			print("Miss!")
			_turn_off_current_lit()

		await get_tree().create_timer(light_interval, false).timeout

func _on_candle_extinguished():
	remaining -= 1
	print("Success! Remaining:", remaining)

	if remaining <= 0:
		win()


func win():
	print("YOU WIN!")
	# turn off any currently lit candle
	if lit_candle and lit_candle.is_lit:
		lit_candle.extinguish(false)

	win_ui.visible = true


func _on_pause_pressed() -> void:
	print("PAUSE CLICKED")
	$PauseMenu.open()

extends Node2D

@export var candle_scene: PackedScene
@onready var candles_container = $candles
@onready var candle_spot_1 = $cake/candleSpot1

func _ready():
	spawn_candles()

func spawn_candles():
	var candle = candle_scene.instantiate()
	candles_container.add_child(candle)
	candle.global_position = candle_spot_1.global_position

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://BirthdayMinigame-help.tscn")
	

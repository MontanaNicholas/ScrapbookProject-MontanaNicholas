extends Node2D

@onready var sfx_ui: AudioStreamPlayer = $SFX_UI

func _on_exit_pressed() -> void:
	Sound.play_ui()
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_play_pressed() -> void:
	Sound.play_ui()
	get_tree().change_scene_to_file("res://travel_minigame.tscn")

func _on_blue_pressed() -> void:
	Sound.play_ui()
	get_tree().change_scene_to_file("res://game.tscn")

func _on_red_pressed() -> void:
	Sound.play_ui()
	get_tree().change_scene_to_file("res://food_drink_main.tscn")

func _on_back_pressed() -> void:
	Sound.play_ui()
	get_tree().change_scene_to_file("res://food_drink_main.tscn")

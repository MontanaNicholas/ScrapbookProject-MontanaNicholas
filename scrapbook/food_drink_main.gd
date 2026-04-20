extends Node2D

@onready var sfx_worm: AudioStreamPlayer = $SFX_WORM
@onready var sfx_ui: AudioStreamPlayer = $SFX_UI

func _on_exit_pressed() -> void:
	Sound.play_ui()
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_button_pressed() -> void:
	Sound.play_ui()
	get_tree().change_scene_to_file("res://game.tscn")

func _on_play_pressed() -> void:
	Sound.play_ui()
	get_tree().change_scene_to_file("res://food_drink_minigame.tscn")

func _on_worm_pressed() -> void:
	Sound.play_worm()
	get_tree().change_scene_to_file("res://main_menu_worm.tscn")

func _on_blue_pressed() -> void:
	Sound.play_ui()
	get_tree().change_scene_to_file("res://game.tscn")

func _on_yellow_pressed() -> void:
	Sound.play_ui()
	get_tree().change_scene_to_file("res://travel_main.tscn")

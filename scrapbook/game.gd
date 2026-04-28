extends Node2D

@onready var sfx_worm: AudioStreamPlayer = $SFX_WORM
@onready var sfx_ui: AudioStreamPlayer = $SFX_UI


func _on_exit_pressed() -> void:
	sfx_ui.play()
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_help_pressed() -> void:
	sfx_ui.play()
	get_tree().change_scene_to_file("res://game.tscn")

func _on_blue_pressed() -> void:
	sfx_ui.play()
	get_tree().change_scene_to_file("res://food_drink_main.tscn")
	
func _on_red_pressed() -> void:
	sfx_ui.play()
	get_tree().change_scene_to_file("res://food_drink_main.tscn")

func _on_yellow_pressed() -> void:
	sfx_ui.play()
	get_tree().change_scene_to_file("res://travel_main.tscn")

func _on_back_pressed() -> void:
	sfx_ui.play()
	get_tree().change_scene_to_file("res://food_drink_main.tscn")

func _on_play_pressed() -> void:
	sfx_ui.play()
	get_tree().change_scene_to_file("res://BirthdayMinigame.tscn")


func _on_worm_pressed() -> void:
	Sound.play_worm()
	get_tree().change_scene_to_file("res://birthday_worm.tscn")

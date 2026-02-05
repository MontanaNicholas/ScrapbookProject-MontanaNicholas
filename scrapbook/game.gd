extends Node2D

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_help_pressed() -> void:
	get_tree().change_scene_to_file("res://help_game.tscn")


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://BirthdayMinigame.tscn")


func _on_blue_pressed() -> void:
	get_tree().change_scene_to_file("res://food_drink_main.tscn")

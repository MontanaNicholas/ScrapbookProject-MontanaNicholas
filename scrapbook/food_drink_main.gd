extends Node2D


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")



func _on_red_pressed() -> void:
	get_tree().change_scene_to_file("res://family_friends.tscn")

func _on_yellow_pressed() -> void:
	get_tree().change_scene_to_file("res://travel_main.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://food_drink_minigame.tscn")

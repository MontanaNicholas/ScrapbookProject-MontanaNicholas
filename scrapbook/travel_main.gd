extends Node2D

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://family_friends.tscn")

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_blue_pressed() -> void:
	get_tree().change_scene_to_file("res://food_drink.tscn")

func _on_red_pressed() -> void:
	get_tree().change_scene_to_file("res://family_friends.tscn")
